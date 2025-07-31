variable "deployment_mode" {
  description = "Choose between 'ec2' or 'asg'"
  type        = string
  default     = "ec2"
}

variable "ami_id" {}
variable "instance_type" {}
variable "user_data_path" {}

variable "environment" {}
variable "tags" { default = {} }

variable "subnet_id" {
  description = "Subnet ID for EC2 instance"
  type        = string
  default     = ""
}

variable "sg_id" {
  description = "Security Group ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for ASG"
  type        = list(string)
  default     = []
}

variable "target_group_arn" {
  description = "ALB target group ARN for ASG"
  type        = string
  default     = ""
}
