# Security Group
output "security_group_id" {
  description = "Security group ID for compute resources"
  value       = var.security_group_id
}

# EC2-specific
output "instance_ids" {
  description = "EC2 instance IDs if in EC2 mode"
  value       = try(aws_instance.this[*].id, null)
}

# ASG-specific
output "asg_name" {
  description = "Auto Scaling Group name if in ASG mode"
  value       = try(aws_autoscaling_group.this[0].id, null)
}

output "asg_arn" {
  description = "Auto Scaling Group ARN if in ASG mode"
  value       = try(aws_autoscaling_group.this[0].arn, null)
}

# Unified target output for ALB
output "target_ids" {
  description = "Targets for ALB registration"
  value = (
    var.compute_mode == "ec2" ? try(aws_instance.this[*].id, []) :
    var.compute_mode == "asg" ? [try(aws_autoscaling_group.this[0].id, null)] :
    []
  )
}
