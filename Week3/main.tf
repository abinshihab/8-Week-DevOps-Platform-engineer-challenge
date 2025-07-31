provider "aws" {
  region = var.aws_region
}

# VPC Module
module "vpc" {
  source              = "./modules/vpc"
  aws_region          = var.aws_region
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs= var.private_subnet_cidrs
  availability_zones  = var.availability_zones
  enable_dns_support  = var.enable_dns_support
  enable_dns_hostnames= var.enable_dns_hostnames
  environment         = var.environment
  user_data = file(var.user_data_path)
  tags                = var.tags
}

# Security Group Module (optional, add only if you copied it into Week3)
module "sg" {
  source      = "./modules/security"
  vpc_id      = module.vpc.vpc_id
  environment = var.environment
  tags        = var.tags
}

# ALB Module
module "alb" {
  source              = "./modules/alb"
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.public_subnet_ids
  security_group_ids  = [module.sg.alb_sg_id]
  environment         = var.environment
  tags                = var.tags
}

# Compute Hybrid Module
module "compute" {
  source              = "./modules/compute-hybrid"
  deployment_mode     = var.deployment_mode

  ami_id              = var.ami_id
  instance_type       = var.instance_type
  user_data_path      = var.user_data_path
  environment         = var.environment
  tags                = var.tags

  subnet_id           = module.vpc.public_subnet_ids[0]
  private_subnet_ids  = module.vpc.private_subnet_ids
  target_group_arn    = module.alb.target_group_arn
  sg_id               = module.sg.ec2_sg_id
}
