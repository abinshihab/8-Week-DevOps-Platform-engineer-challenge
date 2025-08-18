# ===========================
# ALB Outputs
# ===========================

output "alb_arn" {
  description = "The ARN of the Application Load Balancer"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "target_group_arn" {
  description = "The ARN of the target group associated with the ALB"
  value       = aws_lb_target_group.this.arn
}

output "target_group_name" {
  description = "The name of the target group associated with the ALB"
  value       = aws_lb_target_group.this.name
}
