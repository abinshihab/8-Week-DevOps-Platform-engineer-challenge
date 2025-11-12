############################################
# Input Variables for Monitoring Layer
############################################

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev/stage/prod)"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group to monitor"
  type        = string
}

variable "asg_cpu_threshold" {
  description = "CPU utilization threshold for ASG alarm"
  type        = number
  default     = 75
}

variable "alb_arn_suffix" {
  description = "Application Load Balancer ARN suffix"
  type        = string
}

variable "alb_target_group_arn_suffix" {
  description = "Target group ARN suffix for ALB"
  type        = string
}

variable "alb_request_threshold" {
  description = "Request count threshold for ALB alerts"
  type        = number
  default     = 100
}

variable "alerts_email" {
  description = "Email address to receive SNS alerts"
  type        = string
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default = {
    Project   = "CloudMind"
    Challenge = "8-Week-DevOps"
  }
}
