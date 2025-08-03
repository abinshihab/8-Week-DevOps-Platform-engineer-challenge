terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# -----------------------------
# VPC Module
# -----------------------------
module "vpc" {
  source = "./modules/vpc"

  aws_region           = var.aws_region            
  name                 = var.name
  user_data = file(var.user_data_path)
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_nat_gateway   = var.enable_nat_gateway
  tags                 = var.tags
}

# -----------------------------
# Compute Hybrid Module (EC2 / ASG switchable)
# -----------------------------
module "compute" {
  source             = "./modules/compute-hybrid"

  environment        = var.environment
  deployment_mode    = var.deployment_mode

  ami_id             = var.ami_id
  instance_type      = var.instance_type
  key_name           = var.key_name

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids

  tags               = var.tags

  user_data          = file(var.user_data_path)
}

module "alb" {
  source = "./modules/alb"
  environment = var.environment
  vpc_id              = module.vpc.vpc_id
  security_group_ids  = module.vpc.security_group_ids
  subnet_ids = module.vpc.private_subnet_ids

}
