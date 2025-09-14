# outputs.tf - root module

# VPC outputs
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnet_ids
}

# ALB outputs
output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = module.alb.alb_arn
}

output "alb_target_group_arn" {
  description = "Target Group ARN of the ALB"
  value       = module.alb.target_group_arn
}

# Compute outputs (hybrid)
output "asg_names" {
  description = "Name of the Auto Scaling Group (if ASG is enabled)"
  value       = try(module.compute.asg_names, null)
}

output "instance_ids" {
  description = "IDs of single EC2 instance(s) if ASG is disabled"
  value       = try(module.compute.instance_ids, null)
}
