# Security Group for Web Servers (EC2 instances behind ALB)
resource "aws_security_group" "web_sg" {
  name        = "${var.environment}-web-sg"
  description = "Allow HTTP from ALB, optional SSH from trusted IP, ICMP within VPC"
  vpc_id      = var.vpc_id

  #########################
  # Ingress Rules
  #########################

  # 1. Allow HTTP traffic from ALB Security Group
  ingress {
    description     = "Allow HTTP from ALB security group"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [var.alb_security_group_id]  # Only ALB can access HTTP
  }

  # 2. Allow ICMP (ping) from anywhere in the VPC
  ingress {
    description = "Allow ICMP (ping) from VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc_cidr_block]  # VPC-wide ping allowed
  }

  # 3. Optional: Allow SSH from your trusted IP (e.g., home/work)
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

  #########################
  # Egress Rules
  #########################

  # Allow all outbound traffic (for updates, downloads, API calls)
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
