############################################
# Outputs for CloudWatch Alerts Module
############################################

output "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  value       = aws_sns_topic.alerts.arn
}

output "asg_cpu_alarm_name" {
  description = "Name of the ASG CPU alarm"
  value       = aws_cloudwatch_metric_alarm.asg_cpu_high.alarm_name
}

output "alb_unhealthy_alarm_name" {
  description = "Name of the ALB unhealthy hosts alarm"
  value       = aws_cloudwatch_metric_alarm.alb_unhealthy_hosts.alarm_name
}
