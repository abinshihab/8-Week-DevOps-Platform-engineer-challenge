############################################
# 📊 Monitoring Configuration (for Week 7)
############################################
region                      = "us-east-1"
environment                 = "stage"
asg_name                    = "web-asg-stage"
asg_cpu_threshold            = 75
alb_arn_suffix              = "app/cloudmind-alb-stage/abcd1234"
alb_target_group_arn_suffix = "targetgroup/cloudmind-tg-stage/efgh5678"
alb_request_threshold       = 120
alerts_email                = "a.shihab@hotmail.com"

tags = {
  Environment = "stage"
  Owner       = "Ahmed Bin Shehab"
  Project     = "CloudMind"
  Challenge   = "8-Week-DevOps"
}
