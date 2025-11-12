output "sns_topic_arn" {
  description = "SNS topic for CloudWatch alerts"
  value       = module.cloudwatch_alerts.sns_topic_arn
}

# Remove or uncomment when dashboard module added
# output "dashboard_name" {
#   description = "CloudWatch dashboard name"
#   value       = module.cloudwatch_alerts.dashboard_name
# }