# ===========================
# AWS & Environment Settings
# ===========================
aws_region   = "us-east-1"
environment  = "stage"
name         = "web-asg"

# ===========================
# VPC & Subnet Configuration
# ===========================
vpc_cidr = "10.2.0.0/16"

public_subnet_cidrs = [
  "10.2.1.0/24",
  "10.2.2.0/24"
]

private_subnet_cidrs = [
  "10.2.11.0/24",
  "10.2.12.0/24"
]

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]

enable_nat_gateway   = true
enable_dns_support   = true
enable_dns_hostnames = true

# ===========================
# Resource Tags
# ===========================
tags = {
  Environment = "stage"
  Owner       = "Ahmed Bin Shehab"
  Project     = "8-week-cloud-challenge"
}

# ===========================
# Compute (EC2/ASG) Settings
# ===========================
ami_id         = "ami-0e2c86481225d3c51"
instance_type  = "t3.micro"
key_name       = "private-ec2-key"

desired_capacity = 2
min_size         = 1
max_size         = 2
compute_mode    = "asg"

# ===========================
# Optional User Data Script
# ===========================
user_data = file("${path.module}/../../scripts/user_data.sh")

# ===========================
# Database (RDS) Settings
# ===========================
db_engine         = "mysql"
db_engine_version = "8.4.4"
db_instance_class = "db.t3.micro"
db_name           = "devdb"
db_username       = "admin"
alb_arn_suffix = "placeholder-alb"
project        = "my-project"
