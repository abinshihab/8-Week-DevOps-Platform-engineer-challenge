# EC2 Mode
resource "aws_instance" "this" {
  count = var.compute_mode == "ec2" ? 1 : 0

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_ids[0]
  vpc_security_group_ids = [var.security_group_id]

  user_data = var.user_data

  tags = merge(var.tags, {
    Name = "${var.environment}-${var.name}-ec2"
  })
}

# Auto Scaling Group Mode
resource "aws_launch_template" "this" {
  count = var.compute_mode == "asg" ? 1 : 0

  name_prefix             = "${var.environment}-${var.name}-lt-"
  image_id                = var.ami_id
  instance_type           = var.instance_type
  key_name                = var.key_name
  vpc_security_group_ids  = [var.security_group_id]
  user_data               = var.user_data

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name = "${var.environment}-${var.name}-asg"
    })
  }
}

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
resource "aws_lb_target_group_attachment" "this" {
  count            = var.compute_mode == "ec2" ? 1 : 0
  target_group_arn = var.alb_target_group_arn
  target_id        = aws_instance.this[0].id
  port             = 80
}
