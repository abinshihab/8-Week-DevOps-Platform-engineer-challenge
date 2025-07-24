# Terraform VPC Module

This module creates a VPC with:

- Internet Gateway
- Route table
- Multiple public subnets (across AZs)
- Public route association

## Inputs

| Variable             | Description                           | Type          | Example                          |
|----------------------|---------------------------------------|---------------|----------------------------------|
| aws_region           | AWS region                            | string        | `"us-east-1"`                    |
| vpc_cidr             | VPC CIDR block                        | string        | `"10.0.0.0/16"`                  |
| public_subnet_cidrs  | List of public subnet CIDRs           | list(string)  | `["10.0.1.0/24", "10.0.2.0/24"]` |
| availability_zones   | List of availability zones            | list(string)  | `["us-east-1a", "us-east-1b"]`   |
| environment          | Name of the environment               | string        | `"dev"`                          |

## Outputs

| Output               | Description                           |
|----------------------|---------------------------------------|
| vpc_id               | VPC ID                                |
| public_subnet_ids    | List of public subnet IDs             |
| internet_gateway_id  | Internet Gateway ID                   |

## Usage

```hcl
module "vpc" {
  source = "./terraform-vpc-module"

  aws_region           = var.aws_region
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  availability_zones   = var.availability_zones
  environment          = var.environment
}
