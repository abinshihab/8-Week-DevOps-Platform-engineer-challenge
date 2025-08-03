variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the ALB and Target Group"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ALB"
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security group IDs for ALB"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply"
}
