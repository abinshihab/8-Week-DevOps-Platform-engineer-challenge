variable "vpc_id" {
  type        = string
  description = "VPC ID where ALB is deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ALB"
}

variable "environment" {
  type        = string
  description = "Deployment environment name"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
variable "alb_sg_id" {
  description = "Security group ID for the ALB"
  type        = string
}



variable "acm_certificate_arn" {
  type        = string
  description = "ACM Certificate ARN for HTTPS listener"
  default     = ""
}
