resource "aws_security_group" "ec2_sg" {
  name        = "${var.environment}-ec2-sg"
  description = "Allow inbound access"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-ec2-sg"
  })
}

resource "aws_launch_template" "this" {
  name_prefix   = "${var.environment}-lt-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = local.user_data_base64

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]  # 👈 Add this

  tags = {
    Name = "${var.environment}-lt"
  }
}


resource "aws_autoscaling_group" "this" {
  name                      = "${var.environment}-asg"
  desired_capacity          = var.desired_capacity
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.subnet_ids
  health_check_type         = "EC2"
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.environment}-ec2"
    propagate_at_launch = true
  }
}
locals {
  user_data_base64 = base64encode(var.user_data)
}
resource "aws_autoscaling_attachment" "this" {
  count                  = var.target_group_arn != null ? 1 : 0
  autoscaling_group_name = aws_autoscaling_group.this.name
  lb_target_group_arn   = var.alb_target_group_arn

}
