#!/bin/bash
set -euxo pipefail

# Log output
exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1
echo "===== User data script started at $(date) ====="

# Locale settings
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Retry function for yum
retry_yum() {
  local cmd="$1"
  for i in {1..5}; do
    if $cmd; then
      return 0
    fi
    echo "Attempt $i for '$cmd' failed. Retrying in 10s..."
    sleep 10
  done
  echo "❌ '$cmd' failed after 5 attempts."
  return 1
}

# Clean yum cache and update
yum clean all
retry_yum "yum update -y" || {
  echo "⚠️ Falling back to default Amazon Linux mirror"
  sed -i 's|https://.*amazonlinux.*|http://amazonlinux.default.amazonaws.com|g' /etc/yum.repos.d/amzn2*.repo
  retry_yum "yum update -y"
}

# Install Apache
retry_yum "yum install -y httpd"

# Ensure Apache listens on port 80
sed -i '/^Listen /d' /etc/httpd/conf/httpd.conf
echo "Listen 80" >> /etc/httpd/conf/httpd.conf

# Create a simple HTML page
mkdir -p /var/www/html
cat <<'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><title>8 Weeks Challenge</title></head>
<body>
<h1>Welcome to My 8 Weeks Challenge Page</h1>
<p>Deployed via EC2 user-data</p>
</body>
</html>
EOF

# Fix permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Start and enable Apache
systemctl enable httpd
systemctl start httpd || { echo "❌ Apache failed to start"; exit 1; }

# Open HTTP if firewalld exists
if systemctl is-active firewalld >/dev/null 2>&1; then
  firewall-cmd --permanent --add-service=http
  firewall-cmd --reload
fi

# Verify Apache
if ! systemctl is-active --quiet httpd; then
  echo "❌ Apache service not active"
  exit 1
fi

if ! ss -tuln | grep -q ':80'; then
  echo "❌ Apache not listening on port 80"
  exit 1
fi

echo "✅ Apache is up and serving traffic on port 80"
echo "===== User data script completed successfully at $(date) ====="
