variable "compute_mode" {
  type        = string
  description = "EC2 or ASG"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for compute instances or ASG"
}

variable "ami_id" {
  type        = string
  description = "AMI ID to use for instances"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "SSH key name for instances"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID for compute instances"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, prod, etc.)"
}

variable "name" {
  type        = string
  description = "Project name or instance prefix"
}
variable "user_data" {
  description = "User data script for EC2 / ASG instances"
  type        = string
  default     = ""
}
variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
variable "desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
  default     = 1
}
variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
  default     = 2
}
variable "alb_target_group_arn" {
  description = "ARN of the ALB target group to attach EC2 or ASG instances"
  type        = string
  default     = ""   # Optional: can leave empty if you want to attach later
}


