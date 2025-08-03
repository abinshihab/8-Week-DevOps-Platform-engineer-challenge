variable "deployment_mode" {
  type        = string
  description = "Deployment mode: 'ec2' or 'asg'"
  default     = "ec2"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the instances"
}

variable "instance_type" {
  type        = string
  description = "Instance type"
}

variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
  default     = null
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "List of private subnet IDs for instances"
}

variable "user_data" {
  type        = string
  description = "User data script content"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to resources"
  default     = {}
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., dev, prod)"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}