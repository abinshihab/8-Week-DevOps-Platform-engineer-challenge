############################################
# Bastion Host Module 
############################################

#######################
# Security Group
#######################
resource "aws_security_group" "bastion_sg" {
  name        = "${var.name}-bastion-sg"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

  # SSH from your IP
  ingress {
    description = "Allow SSH from trusted IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]  # e.g., "1.2.3.4/32"
  }

  # Allow all outbound traffic
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.name}-bastion-sg" }
}

#######################
# Bastion EC2 Instance
#######################
resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id  # must be public subnet
  vpc_security_group_ids      = [aws_security_group.bastion_sg.id]
  key_name                    = var.key_name
  associate_public_ip_address = true

  tags = { Name = "${var.name}-bastion" }
}
