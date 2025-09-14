#!/bin/bash
# Redirect all output to a logfile and console
exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1
echo "User data script started at $(date)"

# Function to retry yum commands
retry_yum() {
  local cmd=$1
  local retries=5
  local count=0
  until $cmd; do
    exit_code=$?
    count=$((count + 1))
    if [ $count -lt $retries ]; then
      echo "Command failed: $cmd. Retrying in 15 seconds... ($count/$retries)"
      sleep 15
    else
      echo "Command failed after $retries attempts: $cmd"
      return $exit_code
    fi
  done
}

# Update packages safely (optional; skip if you don't need updates at boot)
retry_yum "yum clean all"
retry_yum "yum makecache"
retry_yum "yum -y update"

# Install Apache
retry_yum "yum install -y httpd"

# Ensure Apache listens on all interfaces
cat <<EOL > /etc/httpd/conf.d/listen.conf
Listen 0.0.0.0:80
EOL

# Create a simple HTML page
mkdir -p /var/www/html
echo "Welcome to My 8 Weeks Challenge Page" > /var/www/html/index.html

# Enable and start Apache
systemctl enable httpd
systemctl restart httpd

# Verify Apache is running
if systemctl is-active --quiet httpd; then
  echo "Apache started successfully"
else
  echo "Apache failed to start, check logs in /var/log/httpd/"
fi

echo "User data script completed at $(date)"
