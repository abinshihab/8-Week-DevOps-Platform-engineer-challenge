########################
# Compute Module Outputs
########################

# Security Group ID
output "ec2_sg_id" {
  description = "Security Group ID for EC2 instances"
  value       = aws_security_group.ec2_sg.id
}

# Launch Template ID
output "launch_template_id" {
  description = "ID of the Launch Template"
  value       = aws_launch_template.this.id
}

# Auto Scaling Group ID
output "asg_id" {
  description = "ID of the Auto Scaling Group"
  value       = aws_autoscaling_group.this.id
}

# ASG Desired Capacity
output "asg_desired_capacity" {
  description = "Desired capacity of the ASG"
  value       = aws_autoscaling_group.this.desired_capacity
}

# Subnets used by the ASG
output "asg_subnet_ids" {
  description = "List of subnet IDs used by ASG"
  value       = aws_autoscaling_group.this.vpc_zone_identifier
}

# Note about EC2 Instance IDs
output "asg_instance_ids_note" {
  description = <<EOT
The actual EC2 instance IDs created by the ASG are not available at plan time.
Query them using AWS CLI, AWS Console, or a separate Terraform data source:
- aws_autoscaling_group.instances
- aws_instances data source
EOT
  value = []
}

