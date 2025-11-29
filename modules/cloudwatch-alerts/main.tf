############################################
# CloudWatch Alerts Module (Fixed + Stable)
############################################

locals {
  has_asg = var.asg_name != null && var.asg_name != ""
}

############################################
# SNS Topic for Alerts
############################################

resource "aws_sns_topic" "alerts" {
  name = "${var.environment}-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alerts_email
}

############################################
# ALB High Request Count Alarm
############################################

resource "aws_cloudwatch_metric_alarm" "alb_high_request_count" {
  alarm_name          = "${var.environment}-alb-high-request-count"
  alarm_description   = "Alarm when ALB request count exceeds threshold"
  namespace           = "AWS/ApplicationELB"
  metric_name         = "RequestCount"
  comparison_operator = "GreaterThanThreshold"
  threshold           = var.alb_request_threshold
  period              = 60
  evaluation_periods  = 2
  statistic           = "Sum"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.alb_target_group_arn_suffix
  }
}

############################################
# ALB Unhealthy Hosts Alarm
############################################

resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_hosts" {
  alarm_name          = "${var.environment}-alb-unhealthy-hosts"
  alarm_description   = "Alarm when ALB has unhealthy targets"
  namespace           = "AWS/ApplicationELB"
  metric_name         = "UnHealthyHostCount"
  comparison_operator = "GreaterThanThreshold"
  threshold           = 1
  period              = 60
  evaluation_periods  = 1
  statistic           = "Average"
  alarm_actions       = [aws_sns_topic.alerts.arn]

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.alb_target_group_arn_suffix
  }
}

############################################
# IAM Role for CloudWatch Agent on EC2
############################################

resource "aws_iam_role" "ec2_cw_agent_role" {
  name = "${var.environment}-ec2-cloudwatch-agent-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect  = "Allow"
      Action  = "sts:AssumeRole"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cw_agent_policy" {
  role       = aws_iam_role.ec2_cw_agent_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

############################################
# Auto Scaling Policies (Enabled in Week 8)
############################################

# FIX: Count must depend ONLY on a boolean, never on remote-state data.
# Week 7 has no scaling → enable_asg_scaling = false in tfvars.

resource "aws_autoscaling_policy" "scale_out" {
  count = var.enable_asg_scaling ? 1 : 0

  name                   = "${var.environment}-cpu-scale-out"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 60
  autoscaling_group_name = var.asg_name
}

resource "aws_autoscaling_policy" "scale_in" {
  count = var.enable_asg_scaling ? 1 : 0

  name                   = "${var.environment}-cpu-scale-in"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 60
  autoscaling_group_name = var.asg_name
}

############################################
# ASG CPU High Alarm
############################################


resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  count                 = 1
  alarm_name            = "${var.environment}-asg-cpu-high"
  alarm_description     = "Alarm when ASG CPU exceeds threshold"
  namespace             = "AWS/EC2"
  metric_name           = "CPUUtilization"
  comparison_operator   = "GreaterThanThreshold"
  threshold             = var.asg_cpu_high_threshold
  period                = 60
  evaluation_periods    = 2
  statistic             = "Average"
  alarm_actions         = [aws_sns_topic.alerts.arn]

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}

 ############################################
# ASG CPU Low Alarm
############################################


resource "aws_cloudwatch_metric_alarm" "asg_cpu_low" {
  count                 = 1
  alarm_name            = "${var.environment}-asg-cpu-low"
  alarm_description     = "Alarm when ASG CPU falls below threshold"
  namespace             = "AWS/EC2"
  metric_name           = "CPUUtilization"
  comparison_operator   = "LessThanThreshold"
  threshold             = var.asg_cpu_low_threshold
  period                = 300
  evaluation_periods    = 2
  statistic             = "Average"
  alarm_actions         = [aws_sns_topic.alerts.arn]

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}

