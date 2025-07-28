variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch instances in"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for EC2"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH Key Pair name"
  type        = string
}

variable "user_data_base64" {
  description = "Base64 encoded user data"
  type        = string
  default     = ""
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Min number of instances"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Max number of instances"
  type        = number
  default     = 3
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed for SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data to run on EC2 instance launch"
  type        = string
}
variable "name" {
  description = "Name prefix to use for resources (e.g., Auto Scaling Group)"
  type        = string
}
