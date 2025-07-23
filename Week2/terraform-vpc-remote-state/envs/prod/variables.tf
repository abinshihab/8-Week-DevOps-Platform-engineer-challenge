variable "aws_region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "environment" {
  default = "prod"
}
variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}
variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
}
variable "public_subnet_cidr" {
  description = "CIDR for the public subnet"
  type        = string
}

