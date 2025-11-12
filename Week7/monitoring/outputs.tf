output "sns_topic_arn" {
  description = "SNS topic used for alerts"
  value       = module.cloudwatch_alerts.sns_topic_arn
}

output "asg_cpu_alarm_name" {
  description = "ASG CPU alarm name"
  value       = module.cloudwatch_alerts.asg_cpu_alarm_name
}

output "alb_unhealthy_alarm_name" {
  description = "ALB unhealthy hosts alarm name"
  value       = module.cloudwatch_alerts.alb_unhealthy_alarm_name
}
output "dashboard_name" {
  description = "CloudWatch dashboard name"
  value       = module.cloudwatch_alerts.dashboard_name
}