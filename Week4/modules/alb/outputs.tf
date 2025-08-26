# modules/alb/outputs.tf

# ALB ARN
output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.this.arn
}

# ALB DNS Name
output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.this.dns_name
}

# ALB Security Groups
output "alb_security_group_ids" {
  description = "Security groups attached to the ALB"
  value       = aws_lb.this.security_groups
}

# ALB Target Group ARN
output "target_group_arn" {
  description = "The ARN of the ALB Target Group"
  value       = aws_lb_target_group.this.arn
}

# ALB Target Group Name
output "target_group_name" {
  description = "The name of the ALB Target Group"
  value       = aws_lb_target_group.this.name
}

