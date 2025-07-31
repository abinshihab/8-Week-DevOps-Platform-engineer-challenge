resource "aws_instance" "this" {
  count         = var.deployment_mode == "ec2" ? 1 : 0
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_id]
  user_data     = file(var.user_data_path)
  

  tags = merge(var.tags, {
    Name = "${var.environment}-ec2"
  })
}

resource "aws_launch_template" "this" {
  count               = var.deployment_mode == "asg" ? 1 : 0
  name_prefix         = "${var.environment}-lt-"
  image_id            = var.ami_id
  instance_type       = var.instance_type
  user_data = base64encode(var.user_data) 
  
  vpc_security_group_ids = [var.sg_id]

  tag_specifications {
    resource_type = "instance"
    tags = merge(var.tags, {
      Name = "${var.environment}-asg"
    })
  }
}

resource "aws_autoscaling_group" "this" {
  count                = var.deployment_mode == "asg" ? 1 : 0
  name                 = "${var.environment}-asg"
  desired_capacity     = 2
  min_size             = 1
  max_size             = 3
  vpc_zone_identifier  = var.private_subnet_ids
  target_group_arns    = [var.target_group_arn]
  health_check_type    = "EC2"

  launch_template {
    id      = aws_launch_template.this[0].id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-asg"
    propagate_at_launch = true
  }
}
