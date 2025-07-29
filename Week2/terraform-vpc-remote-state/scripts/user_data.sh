#!/bin/bash
# Update the system
sudo yum update -y

# Install Nginx (or any other package)
sudo amazon-linux-extras install nginx1 -y
sudo systemctl start nginx
sudo systemctl enable nginx

# Custom message to test EC2 launch success
echo "Hello from $(hostname)" | sudo tee /usr/share/nginx/html/index.html
