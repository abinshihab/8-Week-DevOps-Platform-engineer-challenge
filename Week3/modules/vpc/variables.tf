variable "aws_region" {}
variable "environment" {}
variable "vpc_cidr" {}

variable "public_subnet_cidrs" {
  type = list(string)
}

variable "private_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "enable_nat_gateway" {
  type    = bool
  default = false
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "tags" {
  type    = map(string)
  default = {}
}
variable "user_data" {
  description = "User data to run on EC2 instance launch"
  type        = string
}
