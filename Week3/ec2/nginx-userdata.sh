#!/bin/bash
yum update -y
amazon-linux-extras enable nginx1
yum install -y nginx
systemctl start nginx
systemctl enable nginx
echo "<h1>🔥 Nginx running on EC2 🔥</h1>" > /usr/share/nginx/html/index.html

