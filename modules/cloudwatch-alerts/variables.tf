############################################
# Variables for CloudWatch Alerts Module
############################################

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "asg_name" {
  description = "Auto Scaling Group name to monitor"
  type        = string
}

variable "asg_cpu_threshold" {
  description = "CPU utilization threshold for ASG alarm"
  type        = number
  default     = 80
}

variable "alb_arn_suffix" {
  description = "ARN suffix of the ALB"
  type        = string
}

variable "alb_target_group_arn_suffix" {
  description = "ARN suffix of the ALB Target Group"
  type        = string
}

variable "alerts_email" {
  description = "Email to send CloudWatch alerts to"
  type        = string
}

variable "alb_request_threshold" {
  description = "RequestCount threshold for ALB high traffic alarm"
  type        = number
  default     = 500
}