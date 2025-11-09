############################################
# Provider
############################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}


############################################
# VPC Module
############################################
module "vpc" {
  source                    = "../modules/vpc"
  aws_region                = var.aws_region
  project                   = var.name
  environment               = var.environment
  vpc_cidr                  = var.vpc_cidr
  public_subnet_cidrs       = var.public_subnet_cidrs
  private_subnet_cidrs      = var.private_subnet_cidrs
  availability_zones        = var.availability_zones
  enable_dns_hostnames      = var.enable_dns_hostnames
  enable_dns_support        = var.enable_dns_support
  enable_nat_gateway        = var.enable_nat_gateway
  bastion_security_group_id = module.bastion_host.bastion_sg_id
  tags                      = var.tags
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
  source                    = "../modules/Security"
  environment               = var.environment
  vpc_id                    = module.vpc.vpc_id
  alb_security_group_id     = aws_security_group.alb_sg.id
  my_trusted_ip             = data.aws_ssm_parameter.my_trusted_ip.value
  bastion_security_group_id = module.bastion_host.bastion_sg_id
  vpc_cidr_block            = module.vpc.vpc_cidr
  allowed_cidrs = ["10.0.0.0/16"]   # your actual CIDR range
  project = var.project
  tags = var.tags
  
  }
############################################
# ALB Module
############################################
module "alb" {
  source              = "../modules/alb"
  environment         = var.environment
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.public_subnet_ids
  tags                = var.tags
  acm_certificate_arn = var.acm_certificate_arn
  alb_sg_id           = aws_security_group.alb_sg.id

}

############################################
# Create a pulbic route table for the ALB
############################################

resource "aws_route_table" "alb_public_rt" {
  vpc_id = module.vpc.vpc_id

  tags = merge(var.tags, {
    Name = "${var.environment}-alb-public-rt"
  })
}

# Add a route to the Internet Gateway
resource "aws_route" "alb_public_route" {
  route_table_id         = aws_route_table.alb_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.vpc.igw_id
}

############################################
# Compute Module (EC2 / ASG)
############################################
module "compute" {
  source            = "../modules/compute-hybrid"
  compute_mode      = var.compute_mode
  environment       = var.environment
  name              = "app"
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  subnet_ids        = module.vpc.private_subnet_ids
  security_group_id = module.security.alb_sg_id



  # ALB integration
  alb_target_group_arn        = module.alb.target_group_arn
  alb_arn_suffix              = module.alb.alb_arn_suffix
  alb_target_group_arn_suffix = module.alb.target_group_arn_suffix

  # Enable request-based scaling only in stage/prod
  enable_request_based_scaling = var.environment != "dev" ? true : false

  tags = var.tags
}


############################################
# Bastion Host Module
############################################

module "bastion_host" {
  source           = "../modules/bastion_host"
  name             = "dev"
  ami_id           = var.ami_id # Amazon Linux 2
  instance_type    = "t3.micro"
  subnet_id        = module.vpc.public_subnet_ids[0]
  vpc_id           = module.vpc.vpc_id
  allowed_ssh_cidr = local.final_allowed_cidr
  key_name         = "bastion-key"
  bastion_private_ip = "" # This variable is required by the module but not used in the current configuration.
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
############################################
# Cloud Watch Alerts Module
############################################

module "cloudwatch_alerts" {
  source                      = "../modules/cloudwatch-alerts"
  environment                 = var.environment
  asg_name                    = module.compute.asg_name
  asg_cpu_threshold           = 80 # Replace with your desired threshold
  alb_arn_suffix              = module.alb.alb_arn_suffix
  alb_target_group_arn_suffix = module.alb.target_group_arn_suffix
  alerts_email                = "a.shihab@hotmail.com"
}
############################################
# rds Module
############################################

module "rds" {
  source           = "../modules/rds"
  project          = var.project
  environment      = var.environment
  private_subnets  = module.vpc.private_subnets      
  security_groups  = [module.security.db_sg_id]    
  username         = var.db_username
  password         = var.db_password
  env              = var.env 
  tags             = var.tags
}


#############################################
# --- Fetch secure parameters from AWS SSM Parameter Store ---
#############################################

# Database password (SecureString)
data "aws_ssm_parameter" "db_password" {
  name            = "/cloudmind/${var.environment}/db_password"
  with_decryption = true
}

# Allowed SSH CIDR (String)
data "aws_ssm_parameter" "allowed_ssh_cidr" {
  name = "/cloudmind/${var.environment}/allowed_ssh_cidr"
}

# Trusted IP (String)
data "aws_ssm_parameter" "my_trusted_ip" {
  name = "/cloudmind/${var.environment}/my_trusted_ip"
}



#############################################
# --- Combine variable + SSM logic ---
#############################################

locals {
  final_db_password    = data.aws_ssm_parameter.db_password.value
  final_allowed_cidr    = data.aws_ssm_parameter.my_trusted_ip.value 
  final_my_trusted_ip   = data.aws_ssm_parameter.my_trusted_ip.value
}

#############################################
# --- Use parameters in resources ---
#############################################

