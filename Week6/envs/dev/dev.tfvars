# ===========================
# AWS & Environment Settings
# ===========================
aws_region   = "us-east-1"
environment  = "dev"
name         = "web-asg"

# ===========================
# VPC & Subnet Configuration
# ===========================
vpc_cidr = "10.1.0.0/16"

public_subnet_cidrs = [
  "10.1.1.0/24", # us-east-1a
  "10.1.2.0/24"  # us-east-1b
]

private_subnet_cidrs = [
  "10.1.11.0/24", # us-east-1a
  "10.1.12.0/24"  # us-east-1b
]

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]

enable_nat_gateway   = false
enable_dns_support   = true
enable_dns_hostnames = true

# ===========================
# Resource Tags
# ===========================
tags = {
  Environment = "dev"
  Owner       = "Ahmed Bin Shehab"
  Project     = "cc8week"
}

# ===========================
# Compute (EC2/ASG) Settings
# ===========================
ami_id         = "ami-0e2c86481225d3c51"
instance_type  = "t3.micro"
key_name       = "private-ec2-key"

desired_capacity = 2
min_size         = 1
max_size         = 3
compute_mode    = "asg" # cheaper + simpler in dev

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
