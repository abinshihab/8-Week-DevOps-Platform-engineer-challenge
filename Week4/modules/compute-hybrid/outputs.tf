########################
# Outputs for Compute Module
########################

# EC2 instance IDs (only populated in EC2 mode)
output "ec2_instance_ids" {
  value       = try(aws_instance.this[*].id, null)
  description = "IDs of EC2 instances (if EC2 mode)"
}

# Auto Scaling Group name (only populated in ASG mode)
output "asg_name" {
  value       = try(aws_autoscaling_group.this[0].name, null)
  description = "Auto Scaling Group name (if ASG mode)"
}

# Launch Template ID (only populated in ASG mode)
output "launch_template_id" {
  value       = try(aws_launch_template.this[0].id, null)
  description = "Launch Template ID used by the ASG (if ASG mode)"
}

# Security Group used for compute instances
output "compute_security_group_id" {
  value       = var.security_group_id
  description = "Security Group ID applied to EC2/ASG instances"
}
