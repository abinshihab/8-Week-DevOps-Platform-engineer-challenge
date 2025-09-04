########################
# Outputs
########################

# ASG Names
output "asg_names" {
  value       = aws_autoscaling_group.this[*].name
  description = "ASG names (empty if EC2 mode)"
}

# ASG Scaling Policies
output "asg_policy_names" {
  value = concat(
    aws_autoscaling_policy.cpu_scale_target[*].name,
    aws_autoscaling_policy.request_scale_target[*].name,
    aws_autoscaling_policy.scale_out_cpu[*].name,
    aws_autoscaling_policy.scale_in_cpu[*].name
  )
  description = "All ASG scaling policy names (empty if EC2 mode)"
}

# EC2 instance IDs
output "ec2_instance_ids" {
  value = aws_instance.this[*].id
  description = "EC2 instance IDs (only in EC2 mode)"
}

# Launch Template IDs
output "launch_template_ids" {
  value = aws_launch_template.this[*].id
  description = "Launch Template IDs (only in ASG mode)"
}
output "asg_info" {
  value = var.compute_mode == "asg" ? [{
    name     = aws_autoscaling_group.this[0].name
    min_size = aws_autoscaling_group.this[0].min_size
    max_size = aws_autoscaling_group.this[0].max_size
    policies = concat(
      aws_autoscaling_policy.cpu_scale_target[*].name,
      aws_autoscaling_policy.request_scale_target[*].name,
      aws_autoscaling_policy.scale_out_cpu[*].name,
      aws_autoscaling_policy.scale_in_cpu[*].name
    )
  }] : []
  description = "ASG info and scaling policies (empty if EC2 mode)"
}
