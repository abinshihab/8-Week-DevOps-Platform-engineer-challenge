output "asg_name" {
  description = "ASG name if in ASG mode"
  value       = try(aws_autoscaling_group.this.name, null)
}

output "security_group_id" {
  description = "Security group ID for EC2 or ASG"
  value       = aws_security_group.ec2_sg.id
}
