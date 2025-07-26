variable "aws_region" {
  description = "AWS region to deploy the resources"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., dev, stage, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDRs for private subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of Availability Zones"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Enable or disable NAT Gateway"
  type        = bool
}

variable "enable_dns_support" {
  description = "Enable or disable DNS support"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable or disable DNS hostnames"
  type        = bool
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}
