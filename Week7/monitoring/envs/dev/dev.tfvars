############################################
# 📊 Monitoring Configuration (Week 7 - DEV)
############################################

region      = "us-east-1"
environment = "dev"

# Monitoring thresholds (optional override)
asg_cpu_threshold     = 75
alb_request_threshold = 100

# Email for SNS notifications
alerts_email = "a.shihab@hotmail.com"

tags = {
  Environment = "dev"
  Owner       = "Ahmed Bin Shehab"
  Project     = "CloudMind"
  Challenge   = "8-Week-DevOps"
}
