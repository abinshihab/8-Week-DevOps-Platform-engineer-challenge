aws_region         = "us-east-1"
environment        = "dev"
name               = "web-asg"

# VPC settings
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

# Tags
tags = {
  Environment = "dev"
  Owner       = "Ahmed Bin Shehab"
  Project     = "8-week-cloud-challenge"
}

# Compute (EC2/ASG) config
ami_id         = "ami-00350f14f2695dd57"  # ✅ Replace with a real AMI from us-east-1
instance_type  = "t3.micro"
key_name       = "ec2-key"             # ✅ Replace with your actual key pair name

desired_capacity = 2
min_size         = 1
max_size         = 3

# User data script
user_data_path = "../../scripts/user_data.sh"

