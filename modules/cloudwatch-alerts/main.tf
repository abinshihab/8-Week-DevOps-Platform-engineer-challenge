############################################
# CloudWatch Alerts Module
############################################

# Alarm for high CPU usage on EC2 in ASG
resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  alarm_name          = "${var.environment}-asg-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.asg_cpu_threshold
  alarm_description   = "Alarm when average CPU utilization exceeds ${var.asg_cpu_threshold}%"
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  alarm_actions       = [aws_sns_topic.alerts.arn]
}

# Alarm for unhealthy ALB hosts
resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_hosts" {
  alarm_name          = "${var.environment}-alb-unhealthy-hosts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Alarm when ALB has unhealthy hosts"
  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.alb_target_group_arn_suffix
  }
  alarm_actions       = [aws_sns_topic.alerts.arn]
}

# SNS Topic for sending alerts
resource "aws_sns_topic" "alerts" {
  name = "${var.environment}-alerts"
}

# SNS Subscription (email)
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alerts_email
}
# EC2 CloudWatch Agent Role
resource "aws_iam_role" "ec2_cw_agent_role" {
  name = "EC2CloudWatchAgentRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cw_agent_policy" {
  role       = aws_iam_role.ec2_cw_agent_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

