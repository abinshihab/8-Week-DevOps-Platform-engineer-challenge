provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../../modules/vpc"  # adjust this path to your actual module location

  aws_region           = var.aws_region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr

  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones

  enable_nat_gateway   = var.enable_nat_gateway
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags                 = var.tags
}
