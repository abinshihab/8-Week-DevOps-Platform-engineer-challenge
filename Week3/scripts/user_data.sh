#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y
systemctl enable nginx
systemctl start nginx
echo "<h1>🚀 Hello from EC2 via Terraform</h1>" > /usr/share/nginx/html/index.html
