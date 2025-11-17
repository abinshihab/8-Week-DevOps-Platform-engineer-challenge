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

  backend "s3" {
    bucket = "cc8weeks-terraform-state"
    key    = "week7/monitoring/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.region
}

############################################
# Monitoring Stack (CloudWatch Alerts Only)
############################################

module "cloudwatch_alerts" {
  source = "../../modules/cloudwatch-alerts"

  # Environment & region
  environment = var.environment

  # Monitoring Inputs
  alb_arn_suffix              = var.alb_arn_suffix
  alb_target_group_arn_suffix = var.alb_target_group_arn_suffix
  asg_cpu_threshold           = var.asg_cpu_threshold
  alb_request_threshold       = var.alb_request_threshold
  alerts_email                = var.alerts_email

  # ASG name is irrelevant for Week7 — no compute module exists
  asg_name = null
}

