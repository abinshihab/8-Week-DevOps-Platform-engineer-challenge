############################################
# Input Variables for Monitoring Layer
############################################

variable "region" {
  description = "AWS region for monitoring resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev/stage/prod)"
  type        = string
}

############################################
# Monitoring Thresholds (Configurable)
############################################

variable "asg_cpu_threshold" {
  description = "CPU utilization threshold for ASG alarm"
  type        = number
  default     = 75
}

variable "alb_request_threshold" {
  description = "Request count threshold for ALB alerts"
  type        = number
  default     = 100
}

############################################
# Alerts & Notifications
############################################

variable "alerts_email" {
  description = "Email address to receive CloudWatch and SNS alerts"
  type        = string
}

############################################
# Scaling Control (Enabled in Week 8)
############################################

variable "enable_scaling" {
  description = "Enable or disable autoscaling policy creation"
  type        = bool
  default     = false
}

############################################
# Standardized Tags for Monitoring Resources
############################################

variable "tags" {
  description = "Common resource tags applied to monitoring resources"
  type        = map(string)
  default = {
    Project   = "CloudMind"
    Challenge = "8-Week-DevOps"
    Owner     = "Ahmed Bin Shehab"
    Layer     = "Monitoring"
  }
}
