# 📚 Documentation

Complete documentation for the Dark Hacker Homepage project.

## 📁 Directory Structure

```
docs/
├── deployment/           # Deployment-specific documentation
│   ├── README-raspberry-pi.md
│   └── README-k3s-cluster.md
├── guides/              # Setup and configuration guides
│   ├── dns-setup-guide.md
│   └── router-port-forwarding-guide.md
└── README.md           # This file
```

## 📖 Documentation Overview

### 🚀 Deployment Guides

#### [Raspberry Pi Deployment](deployment/README-raspberry-pi.md)
Complete guide for deploying on a single Raspberry Pi with Nginx:
- System requirements and prerequisites
- Automated setup script usage
- Manual configuration steps
- SSL certificate setup
- Security configuration
- Troubleshooting common issues

#### [K3s Cluster Deployment](deployment/README-k3s-cluster.md)
Enterprise-grade Kubernetes deployment guide:
- Multi-node cluster setup
- High availability configuration
- Load balancing with MetalLB
- Monitoring with Prometheus/Grafana
- Scaling and maintenance
- Advanced troubleshooting

### 🔧 Configuration Guides

#### [DNS Setup Guide](guides/dns-setup-guide.md)
Complete DNS configuration instructions:
- Domain record configuration
- DNS propagation verification
- Dynamic DNS setup options
- Nepal (.com.np) specific instructions
- Troubleshooting DNS issues

#### [Router Port Forwarding](guides/router-port-forwarding-guide.md)
Router configuration for worldwide access:
- Port forwarding rules setup
- Common router interfaces
- Security considerations
- Testing connectivity
- Brand-specific instructions

## 🎯 Quick Reference

### Common Commands
```bash
# Local development
python3 -m http.server 8000

# Raspberry Pi deployment
./deployment/raspberry-pi/raspberry-pi-setup.sh

# K3s cluster deployment
./deployment/k3s/k3s-cluster-setup.sh master

# Update website
./scripts/update-k3s-website.sh
```

### Important Files
- **Main README**: [../README.md](../README.md) - Project overview
- **Source Code**: [../src/](../src/) - Website files
- **Deployment**: [../deployment/](../deployment/) - Setup scripts
- **Scripts**: [../scripts/](../scripts/) - Utility scripts

## 🆘 Getting Help

### Troubleshooting Order
1. **Check specific deployment documentation**
2. **Review configuration guides**
3. **Verify network connectivity**
4. **Check system logs**
5. **Validate DNS configuration**

### Common Issues
- **Site not loading**: Check web server status and firewall
- **SSL certificate errors**: Verify domain DNS and Let's Encrypt logs
- **Port forwarding issues**: Test with online port checkers
- **DNS not resolving**: Wait for propagation, try different DNS servers

### Support Resources
- **Project Issues**: GitHub repository issues
- **Community Forums**: Search for similar configurations
- **Official Documentation**: Nginx, K3s, Raspberry Pi OS docs
- **Security Best Practices**: Follow deployment guide security sections
