# -----------------------------
# EC2 Instance (if deployment_mode == "ec2")
# -----------------------------
resource "aws_instance" "this" {
  count         = var.deployment_mode == "ec2" ? 1 : 0

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.private_subnet_ids[0] # or public if needed
  user_data     = var.user_data

  tags = merge(
    var.tags,
    {
      "Name" = "${var.environment}-ec2-instance"
    }
  )
}

# -----------------------------
# Auto Scaling Group (if deployment_mode == "asg")
# -----------------------------

resource "aws_launch_template" "this" {
  count = var.deployment_mode == "asg" ? 1 : 0

  name_prefix   = "${var.environment}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(var.user_data)

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.tags,
      {
        "Name" = "${var.environment}-asg-instance"
      }
    )
  }
}

resource "aws_autoscaling_group" "this" {
  count               = var.deployment_mode == "asg" ? 1 : 0
  name                = "${var.environment}-asg"
  max_size            = 3
  min_size            = 1
  desired_capacity    = 2
  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id      = aws_launch_template.this[0].id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-asg-instance"
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
