############################################
# 📊 Monitoring Configuration (Week 7 - STAGE)
############################################

region      = "us-east-1"
environment = "stage"

# Stage thresholds may be stricter or same as dev
asg_cpu_threshold     = 70
alb_request_threshold = 80

# Stage notifications can go to your same email or group email
alerts_email = "a.shihab@hotmail.com"

tags = {
  Environment = "stage"
  Owner       = "Ahmed Bin Shehab"
  Project     = "CloudMind"
  Challenge   = "8-Week-DevOps"
}
