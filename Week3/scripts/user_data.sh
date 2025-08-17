#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "User data script started at $(date)"

# Install Apache
yum install -y httpd

# Create a simple HTML page
echo "Welcome to My 8 Weeks Challenge Page" > /var/www/html/index.html

# Ensure Apache listens on all interfaces
echo "Listen 0.0.0.0:80" > /etc/httpd/conf.d/listen.conf

# Enable and start Apache
systemctl enable httpd
systemctl start httpd
systemctl status httpd --no-pager
echo "User data script completed at $(date)"