############################################
# Week 6 – Root Module Outputs
# Provides all infrastructure outputs required
# by Week 7 Monitoring Stack
############################################

###############
# VPC Outputs #
###############

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

################
# ALB Outputs  #
################

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "alb_arn" {
  description = "Full ARN of the ALB"
  value       = module.alb.alb_arn
}

output "alb_target_group_arn" {
  description = "Full ARN of the ALB Target Group"
  value       = module.alb.target_group_arn
}

############################################
# Required by Week 7 Monitoring (IMPORTANT)
############################################

# ALB ARN suffix required for CloudWatch metrics
output "alb_arn_suffix" {
  description = "ARN suffix of the ALB (required by CloudWatch metrics)"
  value = replace(
    module.alb.alb_arn,
    "arn:aws:elasticloadbalancing:${var.aws.region}:${data.aws_caller_identity.current.account_id}:loadbalancer/",
    ""
  )
}

# ALB Target Group ARN suffix (for Target Group health metrics)
output "alb_target_group_arn_suffix" {
  description = "ARN suffix of ALB Target Group (required by CloudWatch metrics)"
  value = replace(
    module.alb.alb_target_group_arn,
    "arn:aws:elasticloadbalancing:${var.aws.region}:${data.aws_caller_identity.current.account_id}:targetgroup/",
    ""
  )
}

########################
# Compute (Hybrid)     #
########################

# If ASG is enabled, export ASG name
output "asg_name" {
  description = "Name of the Auto Scaling Group (Week7 uses this for ASG CPU alarms)"
  value       = try(module.compute.asg_names[0], null)
}

# If EC2 single instance mode is enabled, export instance ID
output "instance_id" {
  description = "EC2 Instance ID (if ASG disabled, Week7 uses this for EC2 CPU alarms)"
  value       = try(module.compute.instance_ids[0], null)
}

# Original compute outputs kept for compatibility
output "asg_names" {
  description = "List of ASG names (original output)"
  value       = try(module.compute.asg_names, null)
}

output "instance_ids" {
  description = "List of instance IDs (original output)"
  value       = try(module.compute.instance_ids, null)
}

###############
# RDS Outputs #
###############

output "db_endpoint" {
  description = "RDS endpoint"
  value       = module.rds.db_endpoint
}

output "db_id" {
  description = "RDS instance identifier"
  value       = module.rds.db_id
}
