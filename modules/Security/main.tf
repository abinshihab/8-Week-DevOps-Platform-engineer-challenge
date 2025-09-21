############################################
# Security Group for Web Servers (behind ALB)
############################################
resource "aws_security_group" "web_sg" {
  name        = "${var.environment}-web-sg"
  description = "Allow HTTP from ALB and SSH from Bastion"
  vpc_id      = var.vpc_id

  # HTTP from ALB only
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]
  }

  # SSH from Bastion only
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [var.bastion_security_group_id]
  }

  # ICMP (ping) from VPC
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # Optional SSH from trusted IP
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

  # All outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.environment}-web-sg" })
}

############################################
# Security Group for Database
############################################
resource "aws_security_group" "db_sg" {
  name        = "${var.project}-db-sg"
  description = "Database security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { Name = "${var.project}-db-sg" })
}
