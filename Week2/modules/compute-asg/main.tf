resource "aws_launch_template" "this" {
  name_prefix   = "${var.environment}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  user_data     = filebase64(var.user_data_path)
  vpc_security_group_ids = [var.sg_id]
}

resource "aws_autoscaling_group" "this" {
  name                      = "${var.environment}-asg"
  vpc_zone_identifier       = var.private_subnet_ids
  desired_capacity          = 2
  min_size                  = 1
  max_size                  = 3
  health_check_type         = "EC2"
  target_group_arns         = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-asg"
    propagate_at_launch = true
  }
}
