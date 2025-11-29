############################################
# 📊 Monitoring Configuration (Week 7 - PROD)
############################################

region      = "us-east-1"
environment = "prod"

# Production thresholds are usually tighter
asg_cpu_high_threshold = 80
asg_cpu_low_threshold  = 30
alb_request_threshold = 60

# Email for urgent production alerts
alerts_email = "a.shihab@hotmail.com"

# Tags for Prod
tags = {
  Environment = "prod"
  Owner       = "Ahmed Bin Shehab"
  Project     = "CloudMind"
  Challenge   = "8-Week-DevOps"
}
