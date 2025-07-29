output "web_sg_id" {
  value = aws_security_group.web_sg.id
}
output "alb_sg_id" {
  description = "Security group ID for ALB or web instances"
  value       = aws_security_group.web_sg.id
}