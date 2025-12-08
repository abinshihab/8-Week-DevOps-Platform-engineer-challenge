############################################################
# Terraform + Provider
############################################################
terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

############################################################
# Get Caller Identity (needed for ALB ARN suffix)
############################################################
data "aws_caller_identity" "current" {}

############################################################
# SSM Parameters (Week 6)
############################################################
data "aws_ssm_parameter" "db_password" {
  name            = "/cloudmind/${var.environment}/db_password"
  with_decryption = true
}

data "aws_ssm_parameter" "allowed_ssh_cidr" {
  name = "/cloudmind/${var.environment}/allowed_ssh_cidr"
}

data "aws_ssm_parameter" "my_trusted_ip" {
  name = "/cloudmind/${var.environment}/my_trusted_ip"
}

locals {
  final_db_password  = data.aws_ssm_parameter.db_password.value
  final_allowed_cidr = data.aws_ssm_parameter.allowed_ssh_cidr.value
  final_trusted_ip   = data.aws_ssm_parameter.my_trusted_ip.value
}

############################################################
# VPC Module
############################################################
module "vpc" {
  source                    = "./../../modules/vpc"

  aws_region                = var.aws_region
  project                   = var.project
  environment               = var.environment

  vpc_cidr                  = var.vpc_cidr
  public_subnet_cidrs       = var.public_subnet_cidrs
  private_subnet_cidrs      = var.private_subnet_cidrs
  availability_zones        = var.availability_zones

  enable_dns_hostnames      = var.enable_dns_hostnames
  enable_dns_support        = var.enable_dns_support
  enable_nat_gateway        = var.enable_nat_gateway

  bastion_security_group_id = module.bastion_host.bastion_sg_id

  tags = var.tags
}

############################################################
# ALB Security Group
############################################################
resource "aws_security_group" "alb_sg" {
  name        = "${var.environment}-alb-sg"
  description = "Allow HTTP/HTTPS to ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

############################################################
# Security Module
############################################################
module "security" {
  source                    = "./../../modules/Security"
  environment               = var.environment

  vpc_id                    = module.vpc.vpc_id
  alb_security_group_id     = aws_security_group.alb_sg.id
  my_trusted_ip             = local.final_trusted_ip
  bastion_security_group_id = module.bastion_host.bastion_sg_id
  vpc_cidr_block            = module.vpc.vpc_cidr

  allowed_cidrs = ["10.0.0.0/16"]

  project = var.project
  tags    = var.tags
}

############################################################
# ALB Module
############################################################
module "alb" {
  source              = "./../../modules/alb"
  environment         = var.environment

  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.public_subnet_ids
  alb_sg_id           = aws_security_group.alb_sg.id

  acm_certificate_arn = var.acm_certificate_arn
  tags                = var.tags
}

############################################################
# Compute (EC2 / ASG)
############################################################
module "compute" {
  source            = "./../../modules/compute-hybrid"
  compute_mode      = var.compute_mode
  environment       = var.environment
  name              = "app"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name

  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security.web_sg_id

  alb_target_group_arn        = module.alb.target_group_arn
  alb_arn_suffix              = module.alb.alb_arn_suffix
  alb_target_group_arn_suffix = module.alb.alb_target_group_arn_suffix

  enable_request_based_scaling = var.environment != "prod"

  tags = var.tags
}

############################################################
# Bastion Host
############################################################
module "bastion_host" {
  source             = "./../../modules/bastion_host"
  name               = var.environment
  ami_id             = var.ami_id
  instance_type      = "t3.micro"
  subnet_id          = module.vpc.public_subnet_ids[0]
  vpc_id             = module.vpc.vpc_id
  allowed_ssh_cidr   = local.final_trusted_ip
  key_name           = "bastion-key"
  bastion_private_ip = ""
}

############################################################
# Key Pair + Local File
############################################################
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

############################################################
# RDS
############################################################
module "rds" {
  source          = "./../../modules/rds"

  project         = var.project
  environment     = var.environment

  private_subnets = module.vpc.private_subnets
  security_groups = [module.security.db_sg_id]

  username        = var.db_username
  password        = local.final_db_password

  env             = var.env
  tags            = var.tags
}

############################################################
# WEEK 7 — CLOUDWATCH ALERTS
############################################################
module "cloudwatch_alerts" {
  source                      = "./../../modules/cloudwatch-alerts"
  environment                 = var.environment

  asg_name                    = module.compute.asg_name
  alb_arn_suffix              = module.alb.alb_arn_suffix
  alb_target_group_arn_suffix = module.alb.alb_target_group_arn_suffix

  alerts_email = var.alerts_email
}

