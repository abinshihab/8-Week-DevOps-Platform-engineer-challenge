############################################
# CloudWatch Alerts Module 
############################################

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
# Auto Scaling Policies (Optional for Week6/Week8)
############################################
resource "aws_autoscaling_policy" "scale_out" {
  count = var.enable_scaling && length(var.asg_name) > 0 ? 1 : 0

  name                   = "${var.environment}-cpu-scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = var.asg_name
}

resource "aws_autoscaling_policy" "scale_in" {
  count = var.enable_scaling && length(var.asg_name) > 0 ? 1 : 0

  name                   = "${var.environment}-cpu-scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = var.asg_name
}

############################################
# ASG CPU Alarm (Only if scaling + ASG exist)
############################################
resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  count = (var.asg_name != null) ? 1 : 0

  alarm_name          = "${var.environment}-asg-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.asg_cpu_threshold
  alarm_description   = "Alarm when ASG CPU exceeds ${var.asg_cpu_threshold}%"

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }

  alarm_actions = var.enable_scaling ? [
    aws_autoscaling_policy.scale_out[0].arn,
    aws_sns_topic.alerts.arn
  ] : [aws_sns_topic.alerts.arn]

  ok_actions = var.enable_scaling ? [
    aws_autoscaling_policy.scale_in[0].arn
  ] : []
}

############################################
# ALB Unhealthy Hosts Alarm
############################################
resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_hosts" {
  alarm_name          = "${var.environment}-alb-unhealthy-hosts"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Alarm when ALB has unhealthy targets"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.alb_target_group_arn_suffix
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
}

############################################
# ALB High Request Count Alarm (Traffic Scaling)
############################################
resource "aws_cloudwatch_metric_alarm" "alb_high_request_count" {
  alarm_name          = "${var.environment}-alb-high-request-count"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "RequestCount"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = var.alb_request_threshold
  alarm_description   = "Alarm when ALB request count exceeds threshold"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.alb_target_group_arn_suffix
  }

  alarm_actions = var.enable_scaling ? [
    aws_autoscaling_policy.scale_out[0].arn,
    aws_sns_topic.alerts.arn
  ] : [aws_sns_topic.alerts.arn]

  ok_actions = var.enable_scaling ? [
    aws_autoscaling_policy.scale_in[0].arn
  ] : []
}

############################################
# IAM Role for CloudWatch Agent on EC2
############################################
resource "aws_iam_role" "ec2_cw_agent_role" {
  name = "${var.environment}-ec2-cloudwatch-agent-role"

  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com" },
      "Action": "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "cw_agent_policy" {
  role       = aws_iam_role.ec2_cw_agent_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

locals {
  enable_scaling = var.enable_scaling
}
