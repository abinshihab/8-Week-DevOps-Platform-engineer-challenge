###########################################################
# Combined Outputs – Week 6 + Week 7
# Single file for VPC, ALB, Compute, RDS, Monitoring
###########################################################


###########################################################
# VPC Outputs
###########################################################

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

###########################################################
# ALB Outputs
###########################################################

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "Full ARN of the ALB"
  value       = module.alb.alb_arn
}

output "alb_target_group_arn" {
  description = "ARN of ALB Target Group"
  value       = module.alb.target_group_arn
}



###########################################################
# Compute (Hybrid EC2/ASG)
###########################################################

output "asg_name" {
  description = "Auto Scaling Group name"
  value       = try(module.compute.asg_name, null)
}

output "instance_id" {
  description = "EC2 instance ID (if ASG disabled)"
  value       = try(module.compute.instance_id, null)
}

output "asg_names" {
  description = "List of ASG names"
  value       = try(module.compute.asg_names, null)
}

output "instance_ids" {
  description = "List of EC2 instances"
  value       = try(module.compute.instance_ids, null)
}

###########################################################
# RDS Outputs
###########################################################

output "db_endpoint" {
  description = "RDS database endpoint"
  value       = module.rds.db_endpoint
}

output "db_id" {
  description = "RDS database instance identifier"
  value       = module.rds.db_id
}

###########################################################
# Week 7 Monitoring Outputs
###########################################################

# SNS Topic
output "sns_topic_arn" {
  description = "SNS topic used for CloudWatch alerts"
  value       = module.cloudwatch_alerts.sns_topic_arn
}

# Uncomment when dashboard module is added
# output "dashboard_name" {
#   description = "CloudWatch dashboard name"
#   value       = module.dashboard.dashboard_name
# }
