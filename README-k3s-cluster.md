# 🍓 K3s Raspberry Pi Cluster Deployment Guide

Deploy your hacker-themed homepage on a **high-availability K3s cluster** with two Raspberry Pis for **deepukhadgi.com.np**.

## 🎯 Architecture Overview

```
Internet → Router → Load Balancer (MetalLB) → Nginx Ingress → K3s Cluster
                                                               ├── Pi 1 (Master)
                                                               └── Pi 2 (Worker)
```

## ✨ Features

- ✅ **High Availability** - 2-node cluster with failover
- ✅ **Load Balancing** - MetalLB + Nginx Ingress
- ✅ **Auto SSL** - Let's Encrypt certificates
- ✅ **Rolling Updates** - Zero-downtime deployments
- ✅ **Resource Limits** - Optimized for Raspberry Pi
- ✅ **Monitoring Ready** - ServiceMonitor included
- ✅ **Auto-scaling** - Horizontal Pod Autoscaler ready

## 🚀 Quick Setup

### Prerequisites
- 2 Raspberry Pi (4B recommended, 4GB+ RAM)
- SD cards with Raspberry Pi OS
- Network connectivity between Pis
- Domain: `deepukhadgi.com.np`

### Step 1: Prepare Both Raspberry Pis

Download the setup script on both Pis:
```bash
wget https://raw.githubusercontent.com/deepukhadgi/cursor/main/k3s-cluster-setup.sh
chmod +x k3s-cluster-setup.sh
```

### Step 2: Setup Master Node (Pi 1)

```bash
# On your first Raspberry Pi
./k3s-cluster-setup.sh master
```

This will:
- Install K3s server
- Configure MetalLB load balancer
- Install Nginx Ingress Controller
- Set up cert-manager for SSL
- Deploy your hacker homepage
- Show cluster information

### Step 3: Setup Worker Node (Pi 2)

After master setup completes, note the **Master IP** and **Node Token**, then run on Pi 2:

```bash
# On your second Raspberry Pi
export K3S_URL=https://MASTER_IP:6443
export K3S_TOKEN=NODE_TOKEN_FROM_MASTER
./k3s-cluster-setup.sh worker
```

### Step 4: Verify Cluster

On the master node:
```bash
k3s kubectl get nodes
k3s kubectl get pods -A
k3s kubectl get svc -A
```

## 🌐 Making It Accessible Worldwide

### 1. Get External IP
```bash
# Get the LoadBalancer IP assigned by MetalLB
kubectl get svc -n ingress-nginx ingress-nginx-controller
```

### 2. Configure Router Port Forwarding
Forward these ports to the **LoadBalancer IP**:
- **Port 80** (HTTP) → LoadBalancer IP:80
- **Port 443** (HTTPS) → LoadBalancer IP:443

### 3. DNS Configuration
Point your domain to the **LoadBalancer IP**:
- **A Record**: `@` → `LoadBalancer IP`
- **A Record**: `www` → `LoadBalancer IP`

## 📦 Manual Deployment (Alternative)

If you prefer step-by-step manual setup:

### Install K3s Master
```bash
curl -sfL https://get.k3s.io | sh -s - server \
    --cluster-init \
    --node-name master \
    --disable traefik \
    --disable servicelb \
    --write-kubeconfig-mode 644
```

### Install K3s Worker
```bash
# Get token from master: sudo cat /var/lib/rancher/k3s/server/node-token
curl -sfL https://get.k3s.io | K3S_URL=https://MASTER_IP:6443 K3S_TOKEN=NODE_TOKEN sh -s - agent --node-name worker
```

### Deploy Components
```bash
# MetalLB
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.12/config/manifests/metallb-native.yaml

# Nginx Ingress
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml

# cert-manager
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml

# Deploy website
kubectl apply -f k3s-deployment-manifests.yaml
```

## 🔄 Website Updates

### Automated Update Script
```bash
# Download and run the update script
wget https://raw.githubusercontent.com/deepukhadgi/cursor/main/update-k3s-website.sh
chmod +x update-k3s-website.sh
./update-k3s-website.sh
```

### Manual Update
```bash
# Create new ConfigMap with updated content
kubectl create configmap website-content \
    --from-file=index.html \
    --from-file=styles.css \
    --from-file=script.js \
    -n hacker-site \
    --dry-run=client -o yaml | kubectl apply -f -

# Rolling restart
kubectl rollout restart deployment/hacker-homepage -n hacker-site
```

## 📊 Monitoring & Management

### Cluster Status
```bash
# Check cluster health
kubectl get nodes
kubectl get pods -A
kubectl top nodes
kubectl top pods -A
```

### Website Status
```bash
# Check website pods
kubectl get pods -n hacker-site

# Check ingress
kubectl get ingress -n hacker-site

# Check certificates
kubectl get certificates -n hacker-site
```

### Logs
```bash
# Pod logs
kubectl logs -f deployment/hacker-homepage -n hacker-site

# Ingress logs
kubectl logs -f -n ingress-nginx deployment/ingress-nginx-controller
```

### Resource Usage
```bash
# Install metrics server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# View resource usage
kubectl top nodes
kubectl top pods -n hacker-site
```

## 🔧 Troubleshooting

### Common Issues

#### Pods Stuck in Pending
```bash
kubectl describe pod POD_NAME -n hacker-site
# Check for resource constraints or node issues
```

#### SSL Certificate Issues
```bash
# Check certificate status
kubectl describe certificate hacker-homepage-tls -n hacker-site

# Check cert-manager logs
kubectl logs -n cert-manager deployment/cert-manager
```

#### Ingress Not Working
```bash
# Check ingress controller
kubectl get svc -n ingress-nginx
kubectl logs -n ingress-nginx deployment/ingress-nginx-controller
```

#### Node Not Joining
```bash
# On worker node, check logs
sudo journalctl -u k3s-agent -f

# Verify token and master IP
```

### Cluster Recovery

#### Restart K3s Services
```bash
# Master node
sudo systemctl restart k3s

# Worker node
sudo systemctl restart k3s-agent
```

#### Reset Node (if needed)
```bash
# Uninstall K3s
/usr/local/bin/k3s-uninstall.sh          # Master
/usr/local/bin/k3s-agent-uninstall.sh    # Worker

# Reinstall with setup script
```

## 🚀 Advanced Features

### Horizontal Pod Autoscaler
```bash
# Install metrics server first, then:
kubectl autoscale deployment hacker-homepage \
    --cpu-percent=70 \
    --min=2 \
    --max=6 \
    -n hacker-site
```

### Network Policies
```bash
# Apply network security policies
kubectl apply -f network-policies.yaml
```

### Backup & Restore
```bash
# Backup K3s
sudo cp -r /var/lib/rancher/k3s /backup/

# Restore K3s
sudo cp -r /backup/k3s /var/lib/rancher/
```

## 📈 Performance Optimization

### Resource Limits
The deployment includes optimized resource limits:
- **CPU Request**: 50m (0.05 CPU)
- **CPU Limit**: 100m (0.1 CPU)
- **Memory Request**: 64Mi
- **Memory Limit**: 128Mi

### Scaling
- **Default Replicas**: 3 (across 2 nodes)
- **Max Unavailable**: 1 (during updates)
- **Max Surge**: 1 (during updates)

## 🎉 Final Result

Your hacker-themed homepage will be:
- ✅ **Highly Available** - Survives single node failure
- ✅ **Load Balanced** - Traffic distributed across pods
- ✅ **Auto-SSL** - HTTPS with automatic certificate renewal
- ✅ **Fast** - Optimized Nginx configuration
- ✅ **Scalable** - Ready for traffic growth
- ✅ **Secure** - Network policies and security headers

**Access your site at**: https://deepukhadgi.com.np 🚀

## 🆘 Support

For issues or questions:
1. Check logs with `kubectl logs`
2. Verify cluster status with `kubectl get all -A`
3. Review troubleshooting section above
4. Check Kubernetes documentation

Your professional-grade K3s cluster is ready! 🍓⚡
