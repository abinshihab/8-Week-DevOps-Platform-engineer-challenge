variable "compute_mode" {
  description = "Compute mode: 'ec2' or 'asg'"
  type        = string
  default     = "ec2"
  validation {
    condition     = contains(["ec2", "asg"], var.compute_mode)
    error_message = "compute_mode must be either 'ec2' or 'asg'"
  }
}

variable "ami_id" {
  description = "AMI ID for EC2 or ASG instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type or ASG launch template instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key pair name for EC2/ASG instances"
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "List of subnet IDs for EC2/ASG"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID for compute instances"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "name" {
  description = "Project name or compute module name"
  type        = string
}

variable "tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}

variable "desired_capacity" {
  description = "Desired capacity for ASG"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum size for ASG"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size for ASG"
  type        = number
  default     = 2
}

variable "alb_target_group_arn" {
  description = "ALB target group ARN for registration"
  type        = string
  default     = ""
}

variable "alb_security_group_id" {
  description = "ALB security group ID"
  type        = string
  default     = ""
}

variable "user_data" {
  description = "User data script for EC2/ASG instances"
  type        = string
  default     = ""
}
