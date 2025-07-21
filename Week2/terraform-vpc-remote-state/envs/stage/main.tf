provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source      = "../../modules/vpc"
  vpc_cidr    = var.vpc_cidr
  environment = var.environment
}
