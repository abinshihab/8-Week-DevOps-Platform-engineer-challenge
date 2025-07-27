aws_region         = "us-east-1"
environment        = "stage"
name               = "web-asg"

vpc_cidr           = "10.0.0.0/16"

public_subnet_cidrs  = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

availability_zones   = [
  "us-east-1a",
  "us-east-1b"
]

enable_nat_gateway    = true
enable_dns_support    = true
enable_dns_hostnames  = true

tags = {
  Environment = "dev"
  Owner       = "Ahmed Bin Shehab"
}

ami_id             = "ami-0abcdef1234567890"    # Replace with valid AMI for your region
instance_type      = "t3.micro"
key_name           = "my-aws-key"               # Replace with your key pair name

desired_capacity    = 2
min_size            = 1
max_size            = 3

user_data_path      = "../../scripts/user_data.sh"  # Path relative to envs/dev folder
