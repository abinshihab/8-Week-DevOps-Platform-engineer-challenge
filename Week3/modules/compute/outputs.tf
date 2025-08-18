# ===========================
# Compute / ASG Outputs
# ===========================

output "asg_name" {
  description = "The name of the Auto Scaling Group (if ASG mode is enabled)"
  value       = try(aws_autoscaling_group.this.name, null)
}

output "instance_ids" {
  description = "IDs of EC2 instances launched (either standalone or via ASG)"
  value       = try(aws_instance.this[*].id, [])
}

output "security_group_id" {
  description = "The Security Group ID assigned to the EC2 instances or ASG"
  value       = aws_security_group.ec2_sg.id
}

output "launch_template_id" {
  description = "The ID of the Launch Template used by the ASG (if applicable)"
  value       = try(aws_launch_template.this.id, null)
}
