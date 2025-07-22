# 🍓 Raspberry Pi Deployment Guide

This guide will help you deploy your hacker-themed homepage to your Raspberry Pi with Nginx and make it accessible worldwide at **deepukhadgi.com.np**.

## 🚀 Quick Start

### 1. Download the Setup Script
```bash
# On your Raspberry Pi, run:
wget https://raw.githubusercontent.com/deepukhadgi/cursor/main/raspberry-pi-setup.sh
chmod +x raspberry-pi-setup.sh
```

### 2. Run the Setup Script
```bash
./raspberry-pi-setup.sh
```

The script will:
- ✅ Install Nginx
- ✅ Configure firewall  
- ✅ Clone your website from GitHub
- ✅ Set up Nginx server configuration
- ✅ Optionally configure SSL/HTTPS
- ✅ Create auto-update script

## 📋 Prerequisites

- Raspberry Pi with Raspberry Pi OS (or Ubuntu)
- Internet connection
- Domain: `deepukhadgi.com.np`
- Router admin access (for port forwarding)

## 🔧 Manual Setup (Alternative)

If you prefer manual setup:

### Step 1: Update System
```bash
sudo apt update && sudo apt upgrade -y
```

### Step 2: Install Nginx
```bash
sudo apt install nginx git ufw certbot python3-certbot-nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
```

### Step 3: Configure Firewall
```bash
sudo ufw allow 'Nginx Full'
sudo ufw allow ssh
sudo ufw enable
```

### Step 4: Clone Website
```bash
sudo mkdir -p /var/www/deepukhadgi.com.np
sudo chown -R $USER:www-data /var/www/deepukhadgi.com.np
git clone https://github.com/deepukhadgi/cursor.git /var/www/deepukhadgi.com.np
```

### Step 5: Configure Nginx
```bash
sudo nano /etc/nginx/sites-available/deepukhadgi.com.np
```

Add the configuration from the setup script, then:
```bash
sudo ln -s /etc/nginx/sites-available/deepukhadgi.com.np /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
```

## 🌐 Making It Accessible Worldwide

### 1. Configure Router Port Forwarding
Forward these ports to your Pi's local IP:
- **Port 80** (HTTP) → Pi IP:80
- **Port 443** (HTTPS) → Pi IP:443

See `router-port-forwarding-guide.md` for detailed instructions.

### 2. Set Up DNS Records
Point your domain to your public IP:
```bash
# Find your public IP
curl ifconfig.me
```

Add DNS records at your domain registrar:
- **A Record**: `@` → `[Your Public IP]`
- **A Record**: `www` → `[Your Public IP]`

See `dns-setup-guide.md` for detailed instructions.

### 3. Set Up SSL Certificate (Optional but Recommended)
```bash
sudo certbot --nginx -d deepukhadgi.com.np -d www.deepukhadgi.com.np
```

## 🔄 Updating Your Website

### Automatic Update Script
The setup creates an update script:
```bash
sudo /usr/local/bin/update-website.sh
```

### Manual Update
```bash
cd /var/www/deepukhadgi.com.np
git pull origin main
sudo systemctl reload nginx
```

### Auto-Deploy on Git Push (Advanced)
Set up a webhook or GitHub Action to auto-deploy when you push to GitHub.

## 📊 Monitoring & Maintenance

### Check Nginx Status
```bash
sudo systemctl status nginx
```

### View Nginx Logs
```bash
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### Check SSL Certificate
```bash
sudo certbot certificates
```

### Renew SSL Certificate
```bash
sudo certbot renew
```

## 🛡️ Security Best Practices

1. **Keep System Updated**
   ```bash
   sudo apt update && sudo apt upgrade
   ```

2. **Install Fail2Ban**
   ```bash
   sudo apt install fail2ban
   ```

3. **Change Default SSH Port**
   ```bash
   sudo nano /etc/ssh/sshd_config
   # Change Port 22 to Port 2222
   sudo systemctl restart ssh
   ```

4. **Use Strong Passwords**
   ```bash
   passwd  # Change your user password
   ```

## 🧪 Testing Your Setup

### Local Testing
```bash
curl http://localhost
curl http://[pi-local-ip]
```

### External Testing
```bash
curl http://deepukhadgi.com.np
curl https://deepukhadgi.com.np
```

### Performance Testing
```bash
# Install Apache Bench
sudo apt install apache2-utils

# Test performance
ab -n 100 -c 10 http://deepukhadgi.com.np/
```

## 🎯 Why Nginx vs Apache?

**Nginx is better for Raspberry Pi because:**
- ✅ **Lower memory usage** (~2-4MB vs ~20MB)
- ✅ **Better performance** on limited resources
- ✅ **Faster static file serving**
- ✅ **Better for concurrent connections**
- ✅ **Simpler configuration**

## 📱 Access Your Site

Once everything is configured:
- **Local**: http://[pi-ip]
- **Domain**: http://deepukhadgi.com.np
- **Secure**: https://deepukhadgi.com.np (with SSL)

## 🆘 Troubleshooting

### Website Not Loading
1. Check Nginx status: `sudo systemctl status nginx`
2. Check firewall: `sudo ufw status`
3. Test locally first: `curl http://localhost`

### Domain Not Resolving
1. Check DNS propagation: `dig deepukhadgi.com.np`
2. Wait 24-48 hours for full propagation
3. Try different DNS servers: `nslookup deepukhadgi.com.np 8.8.8.8`

### SSL Issues
1. Check certificate: `sudo certbot certificates`
2. Renew if needed: `sudo certbot renew`
3. Check Nginx config: `sudo nginx -t`

## 🎉 Success!

Your hacker-themed homepage is now:
- 🔒 **Secure** (with HTTPS)
- 🌍 **Accessible worldwide**
- 🔄 **Auto-updating** from GitHub
- ⚡ **Fast** (served by Nginx)
- 🛡️ **Protected** (firewall configured)

Visit: **https://deepukhadgi.com.np** 🚀
