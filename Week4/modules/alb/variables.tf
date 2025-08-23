variable "environment" {
  type        = string
  description = "Environment name (dev, prod, etc.)"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where ALB will be deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for the ALB"
}

variable "alb_sg_id" {
  type        = string
  description = "Security group ID for ALB"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
}

variable "acm_certificate_arn" {
  type        = string
  description = "ACM certificate ARN for HTTPS"
  default     = ""
}
