variable "region" {
  description = "AWS region"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, stage, prod)"
  type        = string
}

variable "asg_name" {
  description = "Auto Scaling Group name"
  type        = string
}

variable "asg_cpu_threshold" {
  description = "CPU utilization threshold for ASG alarm"
  type        = number
  default     = 80
}

variable "alb_arn_suffix" {
  description = "ARN suffix of the Application Load Balancer"
  type        = string
}

variable "alb_target_group_arn_suffix" {
  description = "ARN suffix of the ALB Target Group"
  type        = string
}

variable "alerts_email" {
  description = "Email to receive CloudWatch alerts"
  type        = string
}

variable "alb_request_threshold" {
  description = "Threshold for ALB request count alarm"
  type        = number
  default     = 500
}
variable "dashboard_name" {
  description = "Name of the CloudWatch dashboard"
  type        = string
  default     = null
}

