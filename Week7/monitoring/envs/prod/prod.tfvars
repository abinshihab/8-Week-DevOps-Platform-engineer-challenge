############################################
# 📊 Monitoring Configuration (for Week 7)
############################################
region                      = "us-east-1"
environment                 = "prod"
asg_name                    = "web-asg-prod"
asg_cpu_threshold            = 80
alb_arn_suffix              = "app/cloudmind-alb-prod/abcd1234"
alb_target_group_arn_suffix = "targetgroup/cloudmind-tg-prod/efgh5678"
alb_request_threshold       = 150
alerts_email                = "a.shihab@hotmail.com"

tags = {
  Environment = "prod"
  Owner       = "Ahmed Bin Shehab"
  Project     = "CloudMind"
  Challenge   = "8-Week-DevOps"
}
