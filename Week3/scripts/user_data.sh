#!/bin/bash
echo "User data script started at $(date)" >> /var/log/user-data.log

yum update -y

# Install Apache HTTP Server
yum install -y httpd
mkdir -p /var/www/html
echo "Welcome to My 8 Weeks Challenge Page" > /var/www/html/index.html
echo "Created simple HTML file with OK message at $(date)" >> /var/log/user-data.log
systemctl enable httpd
systemctl start httpd
