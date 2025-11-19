############################################
# Variables for CloudWatch Alerts Module
############################################

variable "environment" {
  description = "Environment name (dev/stage/prod)"
  type        = string
}

variable "asg_name" {
  description = "Auto Scaling Group name (nullable for monitoring-only Week7)"
  type        = string
  default     = null
}

variable "enable_scaling" {
  description = "Enable autoscaling policies (Week6/Week8: true, Week7: false)"
  type        = bool
  default     = true
}

variable "asg_cpu_threshold" {
  description = "CPU utilization threshold for ASG high CPU alarm"
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

variable "alb_request_threshold" {
  description = "RequestCount threshold for ALB traffic spike alarm"
  type        = number
  default     = 500
}

variable "alerts_email" {
  description = "Email to send CloudWatch/SNS alerts to"
  type        = string
}
variable "enable_asg_scaling" {
  description = "Enable or disable the creation of ASG scaling policies"
  type        = bool
  default     = false
}
