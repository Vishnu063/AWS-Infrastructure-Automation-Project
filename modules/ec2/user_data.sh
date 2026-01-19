#!/bin/bash
# User data script for EC2 instances

# Update system
sudo yum update -y

# Install web server
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

# Create index page
cat > /var/www/html/index.html << EOL
<!DOCTYPE html>
<html>
<head>
    <title>${project_name} - ${environment}</title>
    <style>
        body { font-family: Arial; margin: 40px; }
        h1 { color: #2c3e50; }
        .info { background: #f8f9fa; padding: 20px; border-radius: 5px; }
    </style>
</head>
<body>
    <h1>🚀 Welcome to ${project_name}</h1>
    <div class="info">
        <p><strong>Environment:</strong> ${environment}</p>
        <p><strong>Instance ID:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
        <p><strong>Availability Zone:</strong> $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
        <p><strong>Deployed by:</strong> Terraform</p>
    </div>
</body>
</html>
EOL
