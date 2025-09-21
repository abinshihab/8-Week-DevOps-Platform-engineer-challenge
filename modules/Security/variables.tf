variable "environment" {
  description = "Environment name (dev, prod, etc.)"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where SGs will be created"
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

variable "vpc_cidr_block" {
  description = "CIDR block of the VPC for internal traffic"
  type        = string
}

variable "allowed_cidrs" {
  description = "List of CIDR blocks allowed to access the database SG"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "my_trusted_ip" {
  description = "Optional trusted public IP for SSH"
  type        = string
  default     = null
}

variable "tags" {
  description = "Map of tags to apply"
  type        = map(string)
  default     = {}
}
