region              = "us-east-1"
project             = "devops-lab-stage"
vpc_cidr            = "10.0.0.0/16"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.101.0/24", "10.0.102.0/24"]
azs                 = ["us-east-1a", "us-east-1b"]
tags = {
  Environment = "stage"
  Owner       = "Ahmed"
}
