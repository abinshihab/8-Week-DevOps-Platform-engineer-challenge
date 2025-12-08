########################
# Compute Module (EC2 / ASG)
########################

# =======================
# EC2 Mode
# =======================
resource "aws_instance" "this" {
  count = var.compute_mode == "ec2" ? 1 : 0

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = [var.security_group_id]

  user_data = file("${path.module}/../../week6/scripts/user_data.sh")

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.name}-ec2"
  })
}

# Attach EC2 instance to ALB target group (only in EC2 mode)
resource "aws_lb_target_group_attachment" "ec2" {
  count            = var.compute_mode == "ec2" ? 1 : 0
  target_group_arn = var.alb_target_group_arn
  target_id        = aws_instance.this[0].id
  port             = 80
}

# =======================
# ASG Mode
# =======================

# Launch Template (for ASG instances)
resource "aws_launch_template" "this" {
  count = var.compute_mode == "asg" ? 1 : 0

  name_prefix            = "${var.environment}-${var.name}-lt-"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group_id]

  # IAM Role for CloudWatch Agent
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_cw_agent_profile.name
  }
  # Inject user_data for Apache + CloudWatch Agent
  user_data = base64encode(file("${path.root}/scripts/user_data.sh"))

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name = "${var.environment}-${var.name}-asg"
    })
  }
}

# Auto Scaling Group (ASG)
resource "aws_autoscaling_group" "this" {
  count = var.compute_mode == "asg" ? 1 : 0

  name_prefix         = "${var.environment}-asg"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.this[0].id
    version = "$Latest"
  }

  target_group_arns = [var.alb_target_group_arn]

  # Tags for ASG instances
  tag {
    key                 = "Name"
    value               = var.name
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

# =======================
# ASG Scaling Policies
# =======================

# CPU Target Tracking Scaling Policy
resource "aws_autoscaling_policy" "cpu_scale_target" {
  count                  = var.compute_mode == "asg" ? 1 : 0
  name                   = "${var.environment}-${var.name}-cpu-scaling"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.this[0].name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 60
  }
}

# ALB Request-Based Target Tracking Scaling Policy
resource "aws_autoscaling_policy" "request_scale_target" {
  count                  = (var.compute_mode == "asg" && var.enable_request_based_scaling) ? 1 : 0
  name                   = "${var.environment}-${var.name}-req-scaling"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.this[0].name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${var.alb_arn_suffix}/${var.alb_target_group_arn_suffix}"
    }
    target_value = 100
  }
}

# Classic CPU scale-out/in policies
resource "aws_autoscaling_policy" "scale_out_cpu" {
  count                  = var.compute_mode == "asg" ? 1 : 0
  name                   = "${var.environment}-cpu-scale-out"
  adjustment_type         = "ChangeInCapacity"
  scaling_adjustment      = 1
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.this[0].name
}

resource "aws_autoscaling_policy" "scale_in_cpu" {
  count                  = var.compute_mode == "asg" ? 1 : 0
  name                   = "${var.environment}-cpu-scale-in"
  adjustment_type         = "ChangeInCapacity"
  scaling_adjustment      = -1
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.this[0].name
}

# IAM Role for EC2 CloudWatch Agent
resource "aws_iam_role" "ec2_cw_agent_role" {
  name = "${var.environment}-ec2-cw-agent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach AmazonCloudWatchAgentPolicy
resource "aws_iam_role_policy_attachment" "cw_agent_attach" {
  role       = aws_iam_role.ec2_cw_agent_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# Create IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_cw_agent_profile" {
  name = "${var.environment}-ec2-cw-agent-profile"
  role = aws_iam_role.ec2_cw_agent_role.name
}
