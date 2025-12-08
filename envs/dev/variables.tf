#############################
# AWS & Environment Settings
#############################

variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, stage, prod)"
  type        = string
}

variable "env" {
  description = "Alias for environment (legacy use)"
  type        = string
}

variable "name" {
  description = "Name prefix for resources"
  type        = string
}

#############################
# VPC Settings
#############################

variable "vpc_cidr" {
  description = "Main VPC CIDR block"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability Zones to use"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Toggle NAT Gateway creation"
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable DNS support for VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for VPC"
  type        = bool
}

variable "project" {
  description = "Project name for tagging and structuring"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
}

#############################
# Compute / EC2 / ASG
#############################

variable "ami_id" {
  description = "AMI ID for EC2 or ASG instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "SSH key for EC2/ASG"
  type        = string
}

variable "compute_mode" {
  description = "Mode: ec2 or asg"
  type        = string
}

variable "desired_capacity" {
  description = "Desired ASG capacity"
  type        = number
}

variable "min_size" {
  description = "Minimum ASG size"
  type        = number
}

variable "max_size" {
  description = "Maximum ASG size"
  type        = number
}

variable "user_data" {
  description = "User data script for compute nodes"
  type        = string
  default     = ""
}


#############################
# Database (RDS)
#############################

variable "db_engine" {
  description = "Database engine type"
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_name" {
  description = "DB name"
  type        = string
}

variable "db_username" {
  description = "DB username"
  type        = string
}
variable "acm_certificate_arn" {
  description = "ACM Certificate ARN for HTTPS listeners on the ALB"
  type        = string
  default     = ""
}
variable "alerts_email" {
  description = "Email address to receive CloudWatch alarm notifications"
  type        = string
  default     = "a.shihab@hotmail.com"
}


# DO NOT CREATE A VARIABLE FOR db_password — it comes from SSM
# DO NOT CREATE A VARIABLE FOR alb_arn_suffix — this comes from outputs
