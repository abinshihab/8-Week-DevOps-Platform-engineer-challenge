provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source                = "./modules/vpc"
  aws_region            = var.aws_region
  name                  = var.name
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  availability_zones    = var.availability_zones
  enable_dns_hostnames  = true
  enable_dns_support    = true
  tags                  = var.tags
  user_data = file("./scripts/user_data.sh")

}


# ✅ Create ALB Security Group (outside modules to avoid cycles)
resource "aws_security_group" "alb_sg" {
  name        = "${var.environment}-alb-sg"
  description = "Allow HTTP traffic to ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

module "alb" {
  source             = "./modules/alb"
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [aws_security_group.alb_sg.id]
  tags               = var.tags
}
module "compute" {
  source              = "./modules/compute"
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  key_name            = var.key_name
  subnet_ids  = module.vpc.private_subnet_ids
  environment         = var.environment
  tags                = var.tags
  name                = var.name
  vpc_id              =  module.vpc.vpc_id
}
