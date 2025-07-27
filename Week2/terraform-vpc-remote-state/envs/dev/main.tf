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

# --- VPC Module ---
module "vpc" {
  source                = "../../modules/vpc"
  aws_region            = var.aws_region       
  environment           = var.environment
  vpc_cidr              = var.vpc_cidr
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  availability_zones    = var.availability_zones
  enable_nat_gateway    = var.enable_nat_gateway
  enable_dns_support    = var.enable_dns_support
  enable_dns_hostnames  = var.enable_dns_hostnames
  tags                  = var.tags
}

# --- Compute Module ---
module "compute" {
  source              = "../../modules/compute"
  name                = "web-asg"
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  key_name            = var.key_name
  subnet_ids          = module.vpc.public_subnets
  security_group_ids  = [module.vpc.default_sg]
  desired_capacity    = var.desired_capacity
  min_size            = var.min_size
  max_size            = var.max_size
  user_data           = file(var.user_data_path)
  tags                = var.tags
}
