# 🚀 Deployment Options

This directory contains all deployment configurations and scripts for the Dark Hacker Homepage.

## 📁 Directory Structure

```
deployment/
├── raspberry-pi/          # Single Raspberry Pi deployment
│   └── raspberry-pi-setup.sh
├── k3s/                   # Kubernetes cluster deployment
│   ├── k3s-cluster-setup.sh
│   ├── k3s-deployment-manifests.yaml
│   └── k3s-monitoring-setup.sh
└── README.md             # This file
```

## 🍓 Raspberry Pi Deployment

**Best for**: Personal websites, learning, small-scale hosting

**Features**:
- Single-node deployment
- Nginx web server
- SSL with Let's Encrypt
- Automatic firewall configuration
- Low resource usage

**Quick Start**:
```bash
wget https://raw.githubusercontent.com/your-username/your-repo/main/deployment/raspberry-pi/raspberry-pi-setup.sh
chmod +x raspberry-pi-setup.sh
./raspberry-pi-setup.sh
```

**Documentation**: See [docs/deployment/README-raspberry-pi.md](../docs/deployment/README-raspberry-pi.md)

## ⚡ K3s Kubernetes Deployment

**Best for**: Production websites, high availability, scalability

**Features**:
- Multi-node cluster
- High availability
- Load balancing
- Auto-scaling
- Monitoring with Prometheus/Grafana
- Zero-downtime deployments

**Quick Start**:
```bash
# Master node
./deployment/k3s/k3s-cluster-setup.sh master

# Worker node
K3S_URL=https://MASTER_IP:6443 K3S_TOKEN=TOKEN ./deployment/k3s/k3s-cluster-setup.sh worker
```

**Documentation**: See [docs/deployment/README-k3s-cluster.md](../docs/deployment/README-k3s-cluster.md)

## 🔄 Updates

Both deployment methods support automatic updates:

```bash
# Raspberry Pi
sudo /usr/local/bin/update-website.sh

# K3s
./scripts/update-k3s-website.sh
```

## 🆘 Support

- Check the specific deployment documentation
- Review troubleshooting guides in [docs/guides/](../docs/guides/)
- Ensure prerequisites are met before deployment
