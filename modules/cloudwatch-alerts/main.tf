############################################
# CloudWatch Alerts Module 
############################################

# SNS Topic for sending alerts
resource "aws_sns_topic" "alerts" {
  name = "${var.environment}-alerts"
}

# SNS Subscription (Email)
resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = var.alerts_email
}

############################################
# Auto Scaling Policies
############################################

resource "aws_autoscaling_policy" "scale_out" {
  name                   = "${var.environment}-cpu-scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = var.asg_name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "${var.environment}-cpu-scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = var.asg_name
}

############################################
# CloudWatch Alarms
############################################

# Alarm for High CPU in ASG
resource "aws_cloudwatch_metric_alarm" "asg_cpu_high" {
  alarm_name          = "${var.environment}-asg-cpu-high"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = var.asg_cpu_threshold
  alarm_description   = "Alarm when ASG average CPU exceeds ${var.asg_cpu_threshold}%"
  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
  alarm_actions = [
    aws_autoscaling_policy.scale_out.arn,
    aws_sns_topic.alerts.arn
  ]
  ok_actions = [
    aws_autoscaling_policy.scale_in.arn
  ]
}

# Alarm for ALB Unhealthy Hosts
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

# Alarm for ALB High Request Count (Traffic-Based Scaling)
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
  alarm_actions = [
    aws_autoscaling_policy.scale_out.arn,
    aws_sns_topic.alerts.arn
  ]
  ok_actions = [
    aws_autoscaling_policy.scale_in.arn
  ]
}

############################################
# IAM Role for CloudWatch Agent on EC2
############################################

resource "aws_iam_role" "ec2_cw_agent_role" {
  name = "${var.environment}-ec2-cloudwatch-agent-role"

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
