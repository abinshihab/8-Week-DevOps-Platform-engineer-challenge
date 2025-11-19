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

  # Backend: Jenkins will pass backend.conf
  backend "s3" {}
}

provider "aws" {
  region = var.region
}

############################################
# Import Week 6 Compute Stack Outputs
############################################

data "terraform_remote_state" "compute" {
  backend = "s3"

  config = {
    bucket = "cc8weeks-terraform-state"
    key    = "week6/compute/${var.environment}/terraform.tfstate"
    region = "us-east-1"
  }
}

############################################
# Local Values (Safe Access)
############################################

locals {
  instance_id                 = try(data.terraform_remote_state.compute.outputs.instance_id, null)
  asg_name                    = try(data.terraform_remote_state.compute.outputs.asg_name, null)
  alb_arn_suffix              = try(data.terraform_remote_state.compute.outputs.alb_arn_suffix, null)
  alb_target_group_arn_suffix = try(data.terraform_remote_state.compute.outputs.alb_target_group_arn_suffix, null)
}

############################################
# Monitoring Stack (CloudWatch Alerts)
############################################

module "cloudwatch_alerts" {
  source = "../../modules/cloudwatch-alerts"

  environment                 = var.environment

  # Imported automatically from Week 6
  alb_arn_suffix              = local.alb_arn_suffix
  alb_target_group_arn_suffix = local.alb_target_group_arn_suffix
  asg_name                    = local.asg_name

  # Thresholds
  asg_cpu_threshold     = var.asg_cpu_threshold
  alb_request_threshold = var.alb_request_threshold
  alerts_email          = var.alerts_email

  # FIXED: New variable name required by the module
  enable_asg_scaling = var.enable_scaling
}

##############################################
# CloudWatch Dashboard
##############################################

resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${var.environment}-monitoring"

  dashboard_body = templatefile("${path.module}/dashboards/main-dashboard.json", {
    environment                 = var.environment

    # Infra details coming straight from Week 6
    instance_id                 = local.instance_id
    asg_name                    = local.asg_name
    alb_arn_suffix              = local.alb_arn_suffix
    alb_target_group_arn_suffix = local.alb_target_group_arn_suffix
  })
}
