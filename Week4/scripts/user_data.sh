#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "User data script started at $(date)"

# Update and install Apache
yum update -y
yum install -y httpd

# Ensure Apache listens on all interfaces (optional)
cat <<EOL > /etc/httpd/conf.d/listen.conf
Listen 0.0.0.0:80
EOL

# Create a simple HTML page
mkdir -p /var/www/html
echo "Welcome to My 8 Weeks Challenge Page" > /var/www/html/index.html

# Enable and start Apache safely
systemctl enable httpd
systemctl restart httpd

# Verify Apache is running
if systemctl is-active --quiet httpd; then
    echo "Apache started successfully"
else
    echo "Apache failed to start, check logs in /var/log/httpd/"
fi

echo "User data script completed at $(date)"
