############################################
# Outputs for CloudWatch Alerts Module
############################################

output "sns_topic_arn" {
  description = "ARN of the SNS topic for alerts"
  value       = aws_sns_topic.alerts.arn
}

output "asg_cpu_alarm_name" {
  description = "Name of the ASG CPU alarm"
  value       = (
    length(aws_cloudwatch_metric_alarm.asg_cpu_high) > 0 ?
    aws_cloudwatch_metric_alarm.asg_cpu_high[0].alarm_name :
    null
  )
}

output "alb_unhealthy_alarm_name" {
  description = "Name of the ALB unhealthy hosts alarm"
  value       = aws_cloudwatch_metric_alarm.alb_unhealthy_hosts.alarm_name
}

output "scale_out_policy_arn" {
  description = "ARN of the Auto Scaling scale-out policy"
  value       = (
    length(aws_autoscaling_policy.scale_out) > 0 ?
    aws_autoscaling_policy.scale_out[0].arn :
    null
  )
}

output "scale_in_policy_arn" {
  description = "ARN of the Auto Scaling scale-in policy"
  value       = (
    length(aws_autoscaling_policy.scale_in) > 0 ?
    aws_autoscaling_policy.scale_in[0].arn :
    null
  )
}
