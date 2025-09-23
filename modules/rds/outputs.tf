output "rds_endpoint" {
  value = aws_db_instance.db.endpoint
}

output "rds_id" {
  value = aws_db_instance.db.id
}

output "db_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.db.endpoint
}

output "db_id" {
  description = "The DB instance identifier"
  value       = aws_db_instance.db.id
}
