############################################
# Terraform & Provider Configuration
############################################

terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Backend loaded from backend-dev.hcl / backend-stage.hcl / backend-prod.hcl
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

############################################
# Import Week 6 Infrastructure State 
# (VPC, ALB, ASG, EC2, etc.)
############################################

data "terraform_remote_state" "base" {
  backend = "s3"

  config = {
    bucket = "cc8weeks-terraform-state"
    key    = "state/${var.environment}/terraform.tfstate"   # dev/stage/prod
    region = "us-east-1"
  }
}

############################################
# Local Values (Safe Access Wrappers)
############################################

locals {
  # Single instance (when compute_mode=ec2)
  instance_id = try(data.terraform_remote_state.base.outputs.instance_ids[0], null)

  # Auto Scaling Group (Week6 output)
  asg_name = try(data.terraform_remote_state.base.outputs.asg_name, null)

  # ALB metadata
  alb_arn_suffix              = try(data.terraform_remote_state.base.outputs.alb_arn_suffix, null)
  alb_target_group_arn_suffix = try(data.terraform_remote_state.base.outputs.alb_target_group_arn_suffix, null)
}

############################################
# CloudWatch Alerts Module (Week7 Monitoring)
############################################

module "cloudwatch_alerts" {
  source = "../../modules/cloudwatch-alerts"

  environment = var.environment

  #########################################
  # Pulling ASG + ALB metadata from Week6
  #########################################
  asg_name                    = local.asg_name
  alb_arn_suffix              = local.alb_arn_suffix
  alb_target_group_arn_suffix = local.alb_target_group_arn_suffix
  

  #########################################
  # Threshold Controls (tfvars per env)
  #########################################
  asg_cpu_high_threshold  = var.asg_cpu_high_threshold
  asg_cpu_low_threshold   = var.asg_cpu_low_threshold
  alb_request_threshold   = var.alb_request_threshold
  alerts_email            = var.alerts_email

  #########################################
  # Optional scaling (Week8)
  #########################################
  enable_asg_scaling = var.enable_asg_scaling
}

##############################################
# CloudWatch Dashboard
##############################################

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.environment}-monitoring"

  dashboard_body = templatefile("${path.module}/dashboards/main-dashboard.json", {
    environment                 = var.environment
    instance_id                 = try(tostring(local.instance_id), "")
    asg_name                    = try(tostring(local.asg_name), "")
    alb_arn_suffix              = try(tostring(local.alb_arn_suffix), "")
    alb_target_group_arn_suffix = try(tostring(local.alb_target_group_arn_suffix), "")
  })
}
