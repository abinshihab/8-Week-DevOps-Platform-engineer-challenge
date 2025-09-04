#!/bin/bash
# Log all output to both console and file
sudo exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1
sudo echo "User data script started at $(date)"

# Update system and install Apache
sudo yum update -y
sudo yum install -y httpd iproute

# Force Apache to listen on port 80
sudo bash -c 'cat <<EOL > /etc/httpd/conf.d/listen.conf
Listen 0.0.0.0:80
EOL'

# Create a simple HTML page
sudo mkdir -p /var/www/html
sudo bash -c 'echo "<h1>Welcome to My 8 Weeks Challenge Page</h1>" > /var/www/html/index.html'

# Enable and start Apache with retries
sudo systemctl enable httpd
for i in {1..5}; do
  sudo systemctl restart httpd && break
  sudo echo "Retrying Apache start..."
  sleep 5
done

# Give Apache time to start
sleep 10

# Verify Apache service status
if sudo systemctl is-active --quiet httpd; then
  sudo echo "✅ Apache started successfully"
else
  sudo echo "❌ Apache failed to start. Check logs in /var/log/httpd/"
fi

# Verify port 80 is listening
if sudo ss -tuln | grep -q ':80'; then
  sudo echo "✅ Apache is listening on port 80"
else
  sudo echo "❌ Apache is
