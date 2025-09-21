
output "alb_sg_id" {
  description = "Security group ID for ALB (reused as needed)"
  value       = aws_security_group.web_sg.id
}


output "web_sg_id" {
  description = "Security Group ID for web servers"
  value       = aws_security_group.web_sg.id
}

output "db_sg_id" {
  description = "Security Group ID for database"
  value       = aws_security_group.db_sg.id
}
