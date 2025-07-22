# 🖥️ Dark Hacker Homepage

A professional dark-themed terminal-style homepage with cyberpunk aesthetics, designed for developers and tech enthusiasts. Features interactive animations, matrix effects, and a fully responsive design.

## ✨ Features

### 🎨 **Visual Design**
- **Dark Theme** with cyberpunk color scheme (green/black terminal style)
- **Matrix Rain Animation** background effects
- **Terminal-Style Interface** with authentic command prompts
- **Glowing Text Effects** and smooth animations
- **Responsive Design** that works on all devices
- **Custom Scrollbar** and selection styling

### 🚀 **Interactive Elements**
- **Animated Typing Effects** for headers and content
- **Live System Stats** (CPU, Memory, Uptime simulation)
- **Smooth Scrolling Navigation** between sections
- **Project Cards** with hover effects
- **Easter Egg** - Hidden Konami code surprise
- **Particle System** background effects

### 📱 **Sections Included**
1. **Hero Terminal** - Interactive command-line simulation
2. **About** - Developer profile in JSON format with live stats
3. **Projects** - Showcase of hacker-themed projects
4. **Contact** - Terminal-style contact information

## 🛠️ **Tech Stack**

- **HTML5** - Semantic structure
- **CSS3** - Advanced animations and grid layouts
- **Vanilla JavaScript** - Interactive functionality
- **Google Fonts** - Fira Code monospace font
- **No Framework Dependencies** - Pure, lightweight code

## 🚀 **Deployment Options**

This project offers multiple deployment strategies for different needs:

### 1. 🖥️ **Local Development**
```bash
# Clone the repository
git clone https://github.com/your-username/your-repo.git
cd your-repo

# Serve locally
python3 -m http.server 8000
# Visit http://localhost:8000
```

### 2. 🍓 **Raspberry Pi with Nginx**
Perfect for self-hosting with a single Raspberry Pi:

```bash
# Download and run setup script
wget https://raw.githubusercontent.com/your-username/your-repo/main/deployment/raspberry-pi/raspberry-pi-setup.sh
chmod +x raspberry-pi-setup.sh
./raspberry-pi-setup.sh
```

**Features:**
- ✅ Automated Nginx configuration
- ✅ SSL/HTTPS with Let's Encrypt
- ✅ Firewall setup
- ✅ Auto-update script
- ✅ Security headers optimization

**Documentation:** See [docs/deployment/README-raspberry-pi.md](docs/deployment/README-raspberry-pi.md)

### 3. ⚡ **K3s Kubernetes Cluster**
Enterprise-grade deployment with high availability:

```bash
# Master node setup
./deployment/k3s/k3s-cluster-setup.sh master

# Worker node setup (on second Pi)
K3S_URL=https://MASTER_IP:6443 K3S_TOKEN=TOKEN ./deployment/k3s/k3s-cluster-setup.sh worker
```

**Features:**
- ✅ High Availability (2+ nodes)
- ✅ Load Balancing with MetalLB
- ✅ Auto-scaling capabilities
- ✅ Zero-downtime deployments
- ✅ Prometheus + Grafana monitoring
- ✅ Automatic SSL certificate management

**Documentation:** See [docs/deployment/README-k3s-cluster.md](docs/deployment/README-k3s-cluster.md)

## 📊 **Performance Metrics**

- **Lighthouse Score**: 95+ (Performance, Accessibility, SEO)
- **Page Load Time**: <2 seconds
- **First Contentful Paint**: <1 second
- **Bundle Size**: <50KB (no external dependencies)
- **Memory Usage**: <5MB RAM (Raspberry Pi optimized)

## 🔧 **Configuration**

### Environment Variables
```bash
# Optional configuration
DOMAIN="your-domain.com"
EMAIL="your-email@domain.com"
```

### Customization
- Update contact information in `index.html`
- Modify projects in the projects section
- Customize colors in CSS variables
- Add your own matrix characters

## 🔄 **Updates & Maintenance**

### Automatic Updates
Both deployment methods include automatic update scripts:

```bash
# Raspberry Pi Nginx
sudo /usr/local/bin/update-website.sh

# K3s Cluster
./scripts/update-k3s-website.sh
```

### Manual Updates
```bash
git pull origin main
# Restart your web server
```

## 🌐 **Networking Setup**

### Domain Configuration
1. **DNS Records**: Point A records to your server IP
2. **Port Forwarding**: Configure router for ports 80/443
3. **SSL**: Automatic certificate generation included

### Security Features
- **Firewall Configuration** (UFW)
- **Security Headers** (CSP, HSTS, XSS Protection)
- **Rate Limiting** (Nginx/Ingress)
- **HTTPS Redirect** (Automatic)

## 📈 **Monitoring**

### Built-in Monitoring
- **System Stats Display** on homepage
- **Uptime Counter** with live updates
- **Performance Metrics** simulation

### Advanced Monitoring (K3s)
- **Prometheus** metrics collection
- **Grafana** dashboards
- **Custom Raspberry Pi** monitoring
- **Alert Management** for system health

## 🛡️ **Security**

### Security Measures
- ✅ **HTTPS Enforced** with automatic redirects
- ✅ **Security Headers** (XSS, CSRF, Clickjacking protection)
- ✅ **Content Security Policy** implemented
- ✅ **Hidden File Protection** (.git, .env, etc.)
- ✅ **Rate Limiting** to prevent abuse
- ✅ **Firewall Rules** configured automatically

### Best Practices
- Regular system updates included in setup
- Strong password requirements
- Fail2ban integration available
- Network segmentation ready

## 🎯 **Project Structure**

```
📁 project-root/
├── 📄 README.md                    # Main project documentation
├── 📄 LICENSE                     # MIT License
├── 📁 src/                        # Website source code
│   ├── 📄 index.html              # Main homepage
│   ├── 🎨 styles.css              # Dark theme styling
│   ├── ⚡ script.js               # Interactive functionality
│   └── 📚 README.md               # Source code documentation
├── 📁 deployment/                 # Deployment configurations
│   ├── 📁 raspberry-pi/           # Single Pi deployment
│   │   └── 🍓 raspberry-pi-setup.sh
│   ├── 📁 k3s/                    # Kubernetes cluster
│   │   ├── ⚙️ k3s-cluster-setup.sh
│   │   ├── 📊 k3s-monitoring-setup.sh
│   │   └── 🛠️ k3s-deployment-manifests.yaml
│   └── 📚 README.md               # Deployment overview
├── 📁 scripts/                    # Utility scripts
│   ├── 🔄 update-k3s-website.sh   # K3s update script
│   └── 📚 README.md               # Scripts documentation
├── 📁 docs/                       # Documentation
│   ├── 📁 deployment/             # Deployment guides
│   │   ├── 📚 README-raspberry-pi.md
│   │   └── 📚 README-k3s-cluster.md
│   ├── 📁 guides/                 # Configuration guides
│   │   ├── 🌐 dns-setup-guide.md
│   │   └── 🔧 router-port-forwarding-guide.md
│   └── 📚 README.md               # Documentation overview
└── 📁 configs/                    # Configuration files (future use)
```

## 🧪 **Testing**

### Performance Testing
```bash
# Install testing tools
sudo apt install apache2-utils

# Run performance tests
ab -n 100 -c 10 http://your-domain.com/
```

### Security Testing
```bash
# SSL Labs test (online)
# Observatory by Mozilla (online)

# Local security scan
nmap -sV your-domain.com
```

## 🎨 **Customization Guide**

### Color Scheme
```css
:root {
    --bg-primary: #0a0a0a;
    --text-primary: #00ff00;
    --text-accent: #ffff00;
    /* Modify in styles.css */
}
```

### Content Updates
1. **Projects**: Edit the projects section in `index.html`
2. **About**: Update the JSON profile data
3. **Contact**: Modify contact information
4. **Skills**: Add your technology stack

## 🤝 **Contributing**

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Development Setup
```bash
# Fork and clone
git clone https://github.com/your-username/your-fork.git
cd your-fork

# Create feature branch
git checkout -b feature/your-feature

# Make changes and test
python3 -m http.server 8000

# Commit and push
git add .
git commit -m "Add: your feature description"
git push origin feature/your-feature
```

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 **Support & Troubleshooting**

### Common Issues

#### Site Not Loading
1. Check web server status
2. Verify DNS configuration
3. Check firewall rules
4. Review SSL certificate

#### Performance Issues
1. Check resource usage
2. Optimize images
3. Enable compression
4. Review JavaScript console

#### Deployment Issues
1. Verify prerequisites
2. Check network connectivity
3. Review setup logs
4. Ensure proper permissions

### Getting Help
- **Documentation**: Check the deployment-specific README files
- **Logs**: Review web server and application logs
- **Community**: Search for similar issues
- **Issues**: Create detailed bug reports with logs

## 🎉 **Live Demo**

Experience the dark hacker homepage in action:
- **Responsive Design** - Test on different devices
- **Interactive Elements** - Try the typing animations
- **Terminal Simulation** - Explore the command interface
- **Matrix Effects** - Watch the background animations

## ⭐ **Acknowledgments**

- **Matrix Digital Rain** inspiration from The Matrix
- **Terminal Aesthetics** from classic hacker culture
- **Cyberpunk Design** elements from sci-fi themes
- **Open Source Community** for tools and inspiration

---

**Built with ❤️ by developers, for developers**

*Create your own digital identity with style* 🚀