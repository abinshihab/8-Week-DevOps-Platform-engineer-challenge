output "web_sg_id" {
  description = "Security group ID for web/private EC2"
  value       = aws_security_group.web_sg.id
}

output "alb_sg_id" {
  description = "Security group ID for ALB (reused as needed)"
  value       = aws_security_group.web_sg.id
}
