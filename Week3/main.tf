############################################
# Provider
############################################
provider "aws" {
  region = var.aws_region
}

############################################
# VPC Module
############################################
module "vpc" {
  source               = "./modules/vpc"
  aws_region           = var.aws_region
  project              = var.name
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  enable_nat_gateway   = var.enable_nat_gateway
  tags                 = var.tags
}

############################################
# ALB Security Group
############################################
resource "aws_security_group" "alb_sg" {
  name        = "${var.environment}-alb-sg"
  description = "Allow HTTP and HTTPS traffic to ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

############################################
# Web Security Group (for Compute instances)
############################################
module "security" {
  source = "./modules/Security"
  
  environment          = var.environment
  vpc_id               = module.vpc.vpc_id
  alb_security_group_id = aws_security_group.alb_sg.id
  my_trusted_ip        = var.my_trusted_ip
  tags                 = var.tags
}

############################################
# ALB Module
############################################
module "alb" {
  source             = "./modules/alb"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  tags               = var.tags
  acm_certificate_arn = var.acm_certificate_arn  
}


############################################
# Compute Module (EC2 / ASG)
############################################
module "compute" {
  source               = "./modules/compute"
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  subnet_ids           = module.vpc.private_subnet_ids
  environment          = var.environment
  tags                 = var.tags
  name                 = var.name
  vpc_id               = module.vpc.vpc_id

  alb_target_group_arn = module.alb.target_group_arn
  alb_security_group_id = aws_security_group.alb_sg.id

  user_data            = file("./scripts/user_data.sh")

  desired_capacity     = 1
  min_size             = 1
  max_size             = 2
}

############################################
# SSH Key Pair
############################################
resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = "my-generated-key"
  public_key = tls_private_key.example.public_key_openssh
}

resource "local_file" "private_key" {
  content         = tls_private_key.example.private_key_pem
  filename        = "${path.module}/my-generated-key.pem"
  file_permission = "0400"
}
