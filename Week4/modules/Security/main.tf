# Security Group for Web Servers (EC2 instances behind ALB)
resource "aws_security_group" "web_sg" {
  name        = "${var.environment}-web-sg"
  description = "Allow HTTP from ALB, SSH from Bastion, ICMP within VPC"
  vpc_id      = var.vpc_id

  #########################
  # Ingress Rules
  #########################

  # Allow HTTP from ALB
  ingress {
    description     = "Allow HTTP from ALB security group"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  # Allow ICMP (ping) from VPC
  ingress {
    description = "Allow ICMP (ping) from VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # Allow SSH from Bastion host
  ingress {
    description = "Allow SSH from Bastion host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
   cidr_blocks = ["${var.bastion_private_ip}/32"]
  }

  #########################
  # Egress Rules
  #########################

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #########################
  # Tags
  #########################
  tags = merge(var.tags, {
    Name = "${var.environment}-web-sg"
  })
}
