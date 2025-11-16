############################################
# 📊 Monitoring Configuration (for Week 7)
############################################
region                      = "us-east-1"
environment                 = "dev"
asg_name                    = "web-asg-dev"
asg_cpu_threshold            = 75
alb_arn_suffix              = "app/cloudmind-alb-dev/abcd1234"
alb_target_group_arn_suffix = "targetgroup/cloudmind-tg-dev/efgh5678"
alb_request_threshold       = 100
alerts_email                = "a.shihab@hotmail.com"

tags = {
  Environment = "dev"
  Owner       = "Ahmed Bin Shehab"
  Project     = "CloudMind"
  Challenge   = "8-Week-DevOps"
}
