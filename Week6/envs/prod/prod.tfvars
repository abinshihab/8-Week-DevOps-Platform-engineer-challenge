# ===========================
# AWS & Environment Settings
# ===========================
aws_region   = "us-east-1"
environment  = "prod"
name         = "web-asg"

# ===========================
# VPC & Subnet Configuration
# ===========================
vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
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
  Environment = "prod"
  Owner       = "Ahmed Bin Shehab"
  project      = "cc8weeks"
}

# ===========================
# Compute (ASG Mode)
# ===========================
ami_id         = "ami-0e2c86481225d3c51"
instance_type  = "t3.micro"
key_name       = "private-ec2-key"

desired_capacity = 3
min_size         = 1
max_size         = 3
compute_mode     = "asg"

# Enable ALB request-based scaling
enable_request_based_scaling = true

# --- Database configuration ---
db_engine         = "mysql"
db_engine_version = "8.4.4"
db_instance_class = "db.t3.micro"
db_name           = "challenge8w-prod-db"
db_username       = "admin"


