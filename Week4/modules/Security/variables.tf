variable "environment" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where SG will be created"
  type        = string
}

variable "alb_security_group_id" {
  description = "Security Group ID of the ALB"
  type        = string
}

variable "bastion_security_group_id" {
  description = "Security Group ID of the Bastion host"
  type        = string
}

variable "my_trusted_ip" {
  description = "Trusted public IP for optional direct SSH access"
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to apply"
  type        = map(string)
  default     = {}
}
