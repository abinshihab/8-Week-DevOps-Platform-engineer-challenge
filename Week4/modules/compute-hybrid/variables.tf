variable "compute_mode" {
  description = "Compute mode: 'ec2' or 'asg'"
  type        = string
  default     = "ec2"
}

variable "environment" {
  type        = string
  description = "Environment name (dev/prod)"
}

variable "name" {
  type        = string
  description = "Name of the compute resource"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "Key pair name for SSH access"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs"
}

variable "security_group_id" {
  type        = string
  description = "Security Group ID for EC2/ASG instances"
}

variable "alb_target_group_arn" {
  type        = string
  description = "ALB target group ARN to attach instances/ASG"
}

variable "desired_capacity" {
  type        = number
  default     = 1
}

variable "min_size" {
  type        = number
  default     = 1
}

variable "max_size" {
  type        = number 
  default     = 2
}

variable "user_data" {
  type        = string
  default     = ""
}

variable "tags" {
  type        = map(string)
  default     = {}
}
variable "enable_request_based_scaling" {
  type    = bool
  default = false
}

variable "alb_arn_suffix" {
  type    = string
  default = null
}

variable "alb_target_group_arn_suffix" {
  type    = string
  default = null
}
