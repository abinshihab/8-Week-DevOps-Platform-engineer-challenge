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
# Optional: expose scaling policies for visibility or CI/CD integration
output "scale_out_policy_arn" {
  description = "ARN of the Auto Scaling scale-out policy"
  value       = aws_autoscaling_policy.scale_out.arn
}

output "scale_in_policy_arn" {
  description = "ARN of the Auto Scaling scale-in policy"
  value       = aws_autoscaling_policy.scale_in.arn
}

# Optional: IAM role created for CloudWatch Agent on EC2
output "ec2_cloudwatch_agent_role_name" {
  description = "IAM role name for the EC2 CloudWatch Agent"
  value       = aws_iam_role.ec2_cw_agent_role.name
}
