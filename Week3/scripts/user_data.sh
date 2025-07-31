#!/bin/bash
# user_data.sh — Bootstraps EC2 instance on launch

# Update & install basic packages
sudo apt-get update -y
sudo apt-get install -y nginx

# Enable and start nginx
systemctl enable nginx
systemctl start nginx

# Simple landing page
echo "<h1>🚀 Deployed via Terraform with user_data.sh</h1>" > /var/www/html/index.html
