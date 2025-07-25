aws_region           = "us-east-1"
environment          = "dev"
vpc_cidr             = "10.0.0.0/16"

public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]

availability_zones   = ["us-east-1a", "us-east-1b"]

enable_nat_gateway   = true
enable_dns_support   = true
enable_dns_hostnames = true

tags = {
  Project     = "MyVPC"
  Environment = "dev"
}
