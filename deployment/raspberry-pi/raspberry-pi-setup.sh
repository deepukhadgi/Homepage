#!/bin/bash

# Raspberry Pi Nginx Setup Script for deepukhadgi.com.np
# This script sets up Nginx, SSL, and deploys the hacker homepage

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOMAIN="deepukhadgi.com.np"
EMAIL="your-email@example.com"  # Change this to your email
REPO_URL="https://github.com/deepukhadgi/cursor.git"
WEB_ROOT="/var/www/$DOMAIN"
NGINX_CONFIG="/etc/nginx/sites-available/$DOMAIN"

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   print_error "This script should not be run as root. Please run as a regular user with sudo privileges."
   exit 1
fi

print_status "Starting Raspberry Pi Nginx setup for $DOMAIN..."

# Update system
print_status "Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install required packages
print_status "Installing Nginx, Git, and other dependencies..."
sudo apt install -y nginx git ufw certbot python3-certbot-nginx curl

# Start and enable Nginx
print_status "Starting and enabling Nginx..."
sudo systemctl start nginx
sudo systemctl enable nginx

# Configure firewall
print_status "Configuring firewall..."
sudo ufw allow 'Nginx Full'
sudo ufw allow ssh
sudo ufw --force enable

# Create web directory
print_status "Creating web directory..."
sudo mkdir -p $WEB_ROOT
sudo chown -R $USER:www-data $WEB_ROOT
sudo chmod -R 755 $WEB_ROOT

# Clone the website repository
print_status "Cloning website from GitHub..."
if [ -d "$WEB_ROOT/.git" ]; then
    print_status "Repository already exists, pulling latest changes..."
    cd $WEB_ROOT
    git pull origin main
else
    git clone $REPO_URL $WEB_ROOT
fi

# Set correct permissions
sudo chown -R $USER:www-data $WEB_ROOT
sudo chmod -R 755 $WEB_ROOT

# Create Nginx server block
print_status "Creating Nginx configuration..."
sudo tee $NGINX_CONFIG > /dev/null <<NGINXEOF
server {
    listen 80;
    listen [::]:80;
    server_name $DOMAIN www.$DOMAIN;

    root $WEB_ROOT;
    index index.html index.htm;

    # Security headers
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;
    add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_min_length 1024;
    gzip_proxied expired no-cache no-store private must-revalidate auth;
    gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml+rss application/javascript;

    location / {
        try_files \$uri \$uri/ =404;
    }

    # Cache static assets
    location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Security - hide nginx version
    server_tokens off;

    # Block access to hidden files
    location ~ /\. {
        deny all;
        access_log off;
        log_not_found off;
    }
}
NGINXEOF

# Enable the site
print_status "Enabling Nginx site..."
sudo ln -sf $NGINX_CONFIG /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default

# Test Nginx configuration
print_status "Testing Nginx configuration..."
if sudo nginx -t; then
    print_success "Nginx configuration is valid"
    sudo systemctl reload nginx
else
    print_error "Nginx configuration is invalid. Please check the configuration."
    exit 1
fi

print_success "Basic Nginx setup completed!"
print_status "Your website should now be accessible at http://$DOMAIN"

# SSL Setup with Let's Encrypt
read -p "Do you want to set up SSL/HTTPS with Let's Encrypt? (y/n): " setup_ssl

if [[ $setup_ssl =~ ^[Yy]$ ]]; then
    print_status "Setting up SSL certificate..."
    
    # Get email for Let's Encrypt
    read -p "Enter your email address for Let's Encrypt notifications: " EMAIL
    
    # Obtain SSL certificate
    if sudo certbot --nginx -d $DOMAIN -d www.$DOMAIN --non-interactive --agree-tos --email $EMAIL --redirect; then
        print_success "SSL certificate obtained and configured successfully!"
        print_success "Your website is now accessible at https://$DOMAIN"
    else
        print_warning "SSL certificate setup failed. You can try again later with: sudo certbot --nginx -d $DOMAIN"
    fi
    
    # Set up automatic renewal
    print_status "Setting up automatic SSL renewal..."
    (sudo crontab -l 2>/dev/null; echo "0 12 * * * /usr/bin/certbot renew --quiet") | sudo crontab -
fi

# Create update script
print_status "Creating website update script..."
sudo tee /usr/local/bin/update-website.sh > /dev/null <<UPDATEEOF
#!/bin/bash
# Website update script
cd $WEB_ROOT
git pull origin main
sudo chown -R $USER:www-data $WEB_ROOT
sudo chmod -R 755 $WEB_ROOT
sudo systemctl reload nginx
echo "Website updated successfully!"
UPDATEEOF

sudo chmod +x /usr/local/bin/update-website.sh

# Display system information
print_status "Gathering system information..."
echo
echo "=================================="
echo "RASPBERRY PI SETUP COMPLETE!"
echo "=================================="
echo "Domain: $DOMAIN"
echo "Web Root: $WEB_ROOT"
echo "Nginx Config: $NGINX_CONFIG"
echo "Local IP: $(hostname -I | awk '{print $1}')"
echo "Public IP: $(curl -s ifconfig.me)"
echo
echo "NEXT STEPS:"
echo "1. Point your domain DNS to your public IP: $(curl -s ifconfig.me)"
echo "2. Configure port forwarding on your router (port 80 and 443 to your Pi)"
echo "3. Update website anytime with: sudo /usr/local/bin/update-website.sh"
echo
echo "DOMAIN DNS SETTINGS:"
echo "Add these DNS records at your domain registrar:"
echo "A Record: @ -> $(curl -s ifconfig.me)"
echo "A Record: www -> $(curl -s ifconfig.me)"
echo
if [[ $setup_ssl =~ ^[Yy]$ ]]; then
    echo "SSL/HTTPS: ✅ Enabled"
    echo "Website URL: https://$DOMAIN"
else
    echo "SSL/HTTPS: ❌ Not configured"
    echo "Website URL: http://$DOMAIN"
fi
echo "=================================="

print_success "Setup completed! Your hacker homepage is now running on your Raspberry Pi!"
