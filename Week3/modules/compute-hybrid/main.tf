# EC2 mode
resource "aws_instance" "this" {
  count                 = var.compute_mode == "ec2" ? 1 : 0
  ami                   = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = var.subnet_ids[0]
  vpc_security_group_ids = [var.security_group_id]
  key_name              = var.key_name
  user_data             = var.user_data

  tags = merge(var.tags, {
    Name = "${var.name}-ec2"
  })
}

# ASG mode: Launch Template
resource "aws_launch_template" "this" {
  count                 = var.compute_mode == "asg" ? 1 : 0
  name_prefix           = "${var.name}-asg-lt-"
  image_id              = var.ami_id
  instance_type         = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  key_name              = var.key_name
  user_data             = var.user_data

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name = "${var.name}-asg-lt"
    })
  }
}

# ASG mode: Auto Scaling Group
resource "aws_autoscaling_group" "this" {
  count               = var.compute_mode == "asg" ? 1 : 0
  desired_capacity    = var.desired_capacity
  min_size            = var.min_size
  max_size            = var.max_size
  vpc_zone_identifier = var.subnet_ids

  launch_template {
    id      = aws_launch_template.this[0].id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.name}-asg"
    propagate_at_launch = true
  }
}
