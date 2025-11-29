########################
# Outputs - Hybrid Compute
########################

# Auto Scaling Group name(s)
output "asg_names" {
  description = "ASG names (empty if EC2 mode)"
  value       = try(aws_autoscaling_group.this[*].name, [])
}

# Auto Scaling Group detailed info
output "asg_info" {
  description = "ASG info and scaling policies (empty if EC2 mode)"
  value = var.compute_mode == "asg" ? [{
    name     = try(aws_autoscaling_group.this[0].name, null)
    min_size = try(aws_autoscaling_group.this[0].min_size, null)
    max_size = try(aws_autoscaling_group.this[0].max_size, null)
    policies = concat(
      try(aws_autoscaling_policy.cpu_scale_target[*].name, []),
      try(aws_autoscaling_policy.request_scale_target[*].name, []),
      try(aws_autoscaling_policy.scale_out_cpu[*].name, []),
      try(aws_autoscaling_policy.scale_in_cpu[*].name, [])
    )
  }] : []
}

# EC2 Instance IDs
output "instance_ids" {
  description = "EC2 instance IDs (empty if ASG mode)"
  value       = try(aws_instance.this[*].id, [])
}

# Launch Template IDs
output "launch_template_ids" {
  description = "Launch Template IDs (only in ASG mode)"
  value       = try(aws_launch_template.this[*].id, [])
}
output "asg_name" {
  description = "Single Auto Scaling Group name (null if EC2 mode)"
  value       = length(try(aws_autoscaling_group.this, [])) > 0 ? aws_autoscaling_group.this[0].name : null
}

