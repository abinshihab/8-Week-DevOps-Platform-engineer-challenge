# General Configuration
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (dev, stage, prod)"
  type        = string
}

variable "name" {
  description = "Name prefix for all resources"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

# Networking
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
}

variable "enable_dns_support" {
  description = "Enable DNS support"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames"
  type        = bool
  default     = true
}

# EC2/ASG Compute
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2"
  type        = string
}

variable "key_name" {
  description = "SSH key name"
  type        = string
  default     = null
}

variable "user_data_path" {
  description = "Path to user data script"
  type        = string
  default     = "./scripts/user_data.sh"
}

# Deployment Mode Control
variable "deployment_mode" {
  description = "Deployment mode: 'ec2' or 'asg'"
  type        = string
  default     = "asg"
}

variable "use_asg" {
  description = "Deprecated: use deployment_mode instead"
  type        = bool
  default     = false
}
variable "enable_nat_gateway" {
  description = "Whether to enable NAT Gateway for private subnets"
  type        = bool
  default     = false
}
variable "desired_capacity" {
  type        = number
  description = "Number of instances in ASG"
}

variable "min_size" {
  type        = number
  description = "Minimum size of ASG"
}

variable "max_size" {
  type        = number
  description = "Maximum size of ASG"
}
