############################################
# Core Settings
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
# ASG Integration (from Week6 Remote State)
############################################

variable "asg_name" {
  description = "Auto Scaling Group name imported from Week6"
  type        = string
}

############################################
# Monitoring Thresholds
############################################

variable "asg_cpu_high_threshold" {
  description = "High CPU threshold (triggers scale-out alarm)"
  type        = number
  default     = 80
}

variable "asg_cpu_low_threshold" {
  description = "Low CPU threshold (triggers scale-in alarm)"
  type        = number
  default     = 30
}

variable "alb_request_threshold" {
  description = "Threshold for ALB high request count alarm"
  type        = number
  default     = 100
}

############################################
# Alerts & Notifications
############################################

variable "alerts_email" {
  description = "Email address to receive SNS / CloudWatch alerts"
  type        = string
}

############################################
# Scaling Control (Used in Week 8)
############################################

variable "enable_asg_scaling" {
  description = "Enable ASG scaling policies (scale-in/out)"
  type        = bool
  default     = false
}

############################################
# Standardized Tags for Monitoring Resources
############################################

variable "tags" {
  description = "Common resource tags applied to monitoring layer"
  type        = map(string)
  default = {
    Project   = "CloudMind"
    Challenge = "8-Week-DevOps"
    Owner     = "Ahmed Bin Shehab"
    Layer     = "Monitoring"
  }
}


