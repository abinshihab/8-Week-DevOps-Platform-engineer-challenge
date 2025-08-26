# Security Group for Web Servers (EC2 instances behind ALB)
resource "aws_security_group" "web_sg" {
  name        = "${var.environment}-web-sg"
  description = "Allow HTTP from ALB and SSH from bastion"
  vpc_id      = var.vpc_id

  # Ingress rule: Allow HTTP traffic from ALB only
  ingress {
    description     = "Allow HTTP from ALB security group"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [var.alb_security_group_id]
  }

  # Ingress rule: Allow SSH traffic from Bastion host only
  ingress {
    description     = "Allow SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [var.bastion_security_group_id]
  }
  ingress {
    description = "Allow ICMP (ping) from VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr_block]  
  }


  # Optional ingress rule: Allow SSH from your trusted IP
  # Uses dynamic block to include only if variable is not null
  dynamic "ingress" {
    for_each = var.my_trusted_ip != null ? [var.my_trusted_ip] : []
    content {
      description = "Optional SSH from trusted IP"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  # Egress rule: Allow all outbound traffic (required for updates, downloads, API calls)
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Merge additional tags with a Name tag for easy identification
  tags = merge(var.tags, {
    Name = "${var.environment}-web-sg"
  })
}

