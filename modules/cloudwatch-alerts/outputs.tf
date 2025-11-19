############################################
# Outputs for CloudWatch Alerts Module
############################################

output "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  value       = aws_sns_topic.alerts.arn
}

# Week 7: No ASG CPU alarm exists → output is always null.
output "asg_cpu_alarm_name" {
  description = "ASG CPU alarm name (not created in Week 7)"
  value       = null
}

output "alb_unhealthy_alarm_name" {
  description = "Name of the ALB unhealthy hosts alarm"
  value       = aws_cloudwatch_metric_alarm.alb_unhealthy_hosts.alarm_name
}

# Week 7: Scaling is disabled → Never created → Must be null
output "scale_out_policy_arn" {
  description = "Scale-out policy (disabled in Week 7)"
  value       = null
}

output "scale_in_policy_arn" {
  description = "Scale-in policy (disabled in Week 7)"
  value       = null
}
