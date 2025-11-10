############################################
# Provider
############################################
provider "aws" {
  region = var.region
}

############################################
# CloudWatch Monitoring Module Integration
############################################

module "cloudwatch_alerts" {
  source = "../../modules/cloudwatch-alerts"

  environment                 = var.environment
  asg_name                    = var.asg_name
  asg_cpu_threshold           = var.asg_cpu_threshold
  alb_arn_suffix              = var.alb_arn_suffix
  alb_target_group_arn_suffix = var.alb_target_group_arn_suffix
  alerts_email                = var.alerts_email
  alb_request_threshold       = var.alb_request_threshold
}
