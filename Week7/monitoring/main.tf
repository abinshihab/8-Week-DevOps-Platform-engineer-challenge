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

  # Backend configuration provided via backend.conf (by Jenkins)
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

############################################
# Import Week 6 Entire Infrastructure State
############################################
# IMPORTANT:
# Your real state files are located at:
# state/<env>/terraform.tfstate
# NOT week6/compute/...  → (this was wrong)
############################################

data "terraform_remote_state" "base" {
  backend = "s3"

  config = {
    bucket = "cc8weeks-terraform-state"
    key    = "state/${var.environment}/terraform.tfstate"
    region = "us-east-1"
  }
}

############################################
# Local Values (Safe Access)
############################################

locals {
  instance_id                 = try(data.terraform_remote_state.base.outputs.instance_id, null)
  asg_name                    = try(data.terraform_remote_state.base.outputs.asg_name, null)
  alb_arn_suffix              = try(data.terraform_remote_state.base.outputs.alb_arn_suffix, null)
  alb_target_group_arn_suffix = try(data.terraform_remote_state.base.outputs.alb_target_group_arn_suffix, null)
}

############################################
# Monitoring Stack (CloudWatch Alerts)
############################################

module "cloudwatch_alerts" {
  source = "../../modules/cloudwatch-alerts"

  environment                 = var.environment

  # Pulled automatically from Week 6 state
  alb_arn_suffix              = local.alb_arn_suffix
  alb_target_group_arn_suffix = local.alb_target_group_arn_suffix
  asg_name                    = local.asg_name

  # Alert Thresholds
  asg_cpu_threshold     = var.asg_cpu_threshold
  alb_request_threshold = var.alb_request_threshold
  alerts_email          = var.alerts_email

  # Optional ASG scaling from Week7
  enable_asg_scaling = var.enable_scaling
}

##############################################
# CloudWatch Dashboard
##############################################

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.environment}-monitoring"

  dashboard_body = templatefile("${path.module}/dashboards/main-dashboard.json", {
    environment                 = var.environment
    instance_id                 = local.instance_id
    asg_name                    = local.asg_name
    alb_arn_suffix              = local.alb_arn_suffix
    alb_target_group_arn_suffix = local.alb_target_group_arn_suffix
  })
}
