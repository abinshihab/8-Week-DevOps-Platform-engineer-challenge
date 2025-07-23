provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr            = var.vpc_cidr
  environment         = var.environment
  aws_region          = var.aws_region
  public_subnet_cidr  = var.public_subnet_cidr   
  availability_zone   = var.availability_zone    
}
