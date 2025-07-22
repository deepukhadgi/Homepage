#!/bin/bash

# K3s Cluster Setup Script for Raspberry Pi
# This script sets up a 2-node K3s cluster for deepukhadgi.com.np

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Configuration
DOMAIN="deepukhadgi.com.np"
CLUSTER_NAME="hacker-cluster"

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

print_header() {
    echo "============================================"
    echo "🍓 K3s Raspberry Pi Cluster Setup"
    echo "🌐 Domain: $DOMAIN"
    echo "�� Cluster: $CLUSTER_NAME"
    echo "============================================"
}

check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check if running on Raspberry Pi
    if ! grep -q "Raspberry Pi" /proc/cpuinfo 2>/dev/null; then
        print_warning "This doesn't appear to be a Raspberry Pi, but continuing anyway..."
    fi
    
    # Check architecture
    ARCH=$(uname -m)
    if [[ "$ARCH" != "aarch64" && "$ARCH" != "armv7l" ]]; then
        print_warning "Architecture $ARCH detected. K3s supports ARM64 and ARMv7."
    fi
    
    # Check memory (recommended 1GB+)
    MEMORY_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
    MEMORY_MB=$((MEMORY_KB / 1024))
    
    if [ $MEMORY_MB -lt 1024 ]; then
        print_warning "Only ${MEMORY_MB}MB RAM detected. 1GB+ recommended for K3s."
    else
        print_success "Memory check passed: ${MEMORY_MB}MB RAM"
    fi
    
    print_success "Prerequisites check completed"
}

setup_node() {
    NODE_TYPE=$1
    
    print_status "Setting up $NODE_TYPE node..."
    
    # Update system
    print_status "Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    
    # Install required packages
    print_status "Installing dependencies..."
    sudo apt install -y curl wget git vim htop
    
    # Enable cgroups (required for K3s on Raspberry Pi)
    print_status "Configuring boot parameters for K3s..."
    if ! grep -q "cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory" /boot/cmdline.txt; then
        sudo cp /boot/cmdline.txt /boot/cmdline.txt.backup
        sudo sed -i '$ s/$/ cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory/' /boot/cmdline.txt
        print_warning "Boot parameters updated. Reboot required after setup."
    fi
    
    # Disable swap (recommended for Kubernetes)
    print_status "Disabling swap..."
    sudo dphys-swapfile swapoff || true
    sudo dphys-swapfile uninstall || true
    sudo systemctl disable dphys-swapfile || true
    
    print_success "$NODE_TYPE node preparation completed"
}

install_k3s_master() {
    print_status "Installing K3s master node..."
    
    # Install K3s server
    curl -sfL https://get.k3s.io | sh -s - server \
        --cluster-init \
        --node-name master \
        --disable traefik \
        --disable servicelb \
        --write-kubeconfig-mode 644
    
    # Wait for K3s to be ready
    print_status "Waiting for K3s to be ready..."
    sleep 30
    
    # Get node token for worker nodes
    NODE_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
    MASTER_IP=$(hostname -I | awk '{print $1}')
    
    print_success "K3s master installed successfully!"
    print_status "Master IP: $MASTER_IP"
    print_status "Node Token: $NODE_TOKEN"
    
    # Save cluster info
    echo "MASTER_IP=$MASTER_IP" > /tmp/k3s-cluster-info
    echo "NODE_TOKEN=$NODE_TOKEN" >> /tmp/k3s-cluster-info
    
    # Install kubectl alias
    echo 'alias kubectl="k3s kubectl"' >> ~/.bashrc
    
    print_status "To join worker nodes, run on worker Pi:"
    print_status "curl -sfL https://get.k3s.io | K3S_URL=https://$MASTER_IP:6443 K3S_TOKEN=$NODE_TOKEN sh -s - agent --node-name worker"
}

install_k3s_worker() {
    print_status "Installing K3s worker node..."
    
    if [ -z "$K3S_URL" ] || [ -z "$K3S_TOKEN" ]; then
        print_error "K3S_URL and K3S_TOKEN environment variables must be set for worker installation"
        print_error "Example: K3S_URL=https://MASTER_IP:6443 K3S_TOKEN=NODE_TOKEN ./k3s-cluster-setup.sh worker"
        exit 1
    fi
    
    # Install K3s agent
    curl -sfL https://get.k3s.io | sh -s - agent --node-name worker
    
    print_success "K3s worker installed successfully!"
}

install_metallb() {
    print_status "Installing MetalLB load balancer..."
    
    # Apply MetalLB
    k3s kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.12/config/manifests/metallb-native.yaml
    
    # Wait for MetalLB to be ready
    print_status "Waiting for MetalLB to be ready..."
    k3s kubectl wait --namespace metallb-system \
        --for=condition=ready pod \
        --selector=app=metallb \
        --timeout=90s
    
    # Get IP range for MetalLB
    LOCAL_IP=$(hostname -I | awk '{print $1}')
    IP_PREFIX=$(echo $LOCAL_IP | cut -d. -f1-3)
    
    # Create MetalLB IP address pool
    cat <<METALLB_EOF | k3s kubectl apply -f -
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: default
  namespace: metallb-system
spec:
  addresses:
  - ${IP_PREFIX}.240-${IP_PREFIX}.250
---
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: default
  namespace: metallb-system
spec:
  ipAddressPools:
  - default
METALLB_EOF
    
    print_success "MetalLB installed with IP pool: ${IP_PREFIX}.240-250"
}

install_nginx_ingress() {
    print_status "Installing Nginx Ingress Controller..."
    
    # Install Nginx Ingress
    k3s kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml
    
    # Wait for ingress to be ready
    print_status "Waiting for Nginx Ingress to be ready..."
    k3s kubectl wait --namespace ingress-nginx \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/component=controller \
        --timeout=90s
    
    print_success "Nginx Ingress Controller installed successfully!"
}

deploy_website() {
    print_status "Deploying hacker homepage to K3s..."
    
    # Create namespace
    k3s kubectl create namespace hacker-site || true
    
    # Create deployment
    cat <<DEPLOY_EOF | k3s kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hacker-homepage
  namespace: hacker-site
  labels:
    app: hacker-homepage
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hacker-homepage
  template:
    metadata:
      labels:
        app: hacker-homepage
    spec:
      containers:
      - name: nginx
        image: nginx:alpine
        ports:
        - containerPort: 80
        volumeMounts:
        - name: website-content
          mountPath: /usr/share/nginx/html
        - name: nginx-config
          mountPath: /etc/nginx/conf.d/default.conf
          subPath: default.conf
      volumes:
      - name: website-content
        configMap:
          name: website-content
      - name: nginx-config
        configMap:
          name: nginx-config
---
apiVersion: v1
kind: Service
metadata:
  name: hacker-homepage-service
  namespace: hacker-site
spec:
  selector:
    app: hacker-homepage
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hacker-homepage-ingress
  namespace: hacker-site
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - $DOMAIN
    - www.$DOMAIN
    secretName: hacker-homepage-tls
  rules:
  - host: $DOMAIN
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: hacker-homepage-service
            port:
              number: 80
  - host: www.$DOMAIN
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: hacker-homepage-service
            port:
              number: 80
DEPLOY_EOF

    print_success "Website deployment created!"
}

install_cert_manager() {
    print_status "Installing cert-manager for SSL certificates..."
    
    # Install cert-manager
    k3s kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.2/cert-manager.yaml
    
    # Wait for cert-manager to be ready
    print_status "Waiting for cert-manager to be ready..."
    k3s kubectl wait --namespace cert-manager \
        --for=condition=ready pod \
        --selector=app.kubernetes.io/instance=cert-manager \
        --timeout=90s
    
    # Create Let's Encrypt cluster issuer
    cat <<CERT_EOF | k3s kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-prod
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: admin@$DOMAIN
    privateKeySecretRef:
      name: letsencrypt-prod
    solvers:
    - http01:
        ingress:
          class: nginx
CERT_EOF
    
    print_success "cert-manager installed with Let's Encrypt issuer!"
}

create_website_content() {
    print_status "Creating website content ConfigMap..."
    
    # Clone the repository to get website files
    TEMP_DIR=$(mktemp -d)
    git clone https://github.com/deepukhadgi/cursor.git $TEMP_DIR
    
    # Create ConfigMap with website content
    k3s kubectl create configmap website-content \
        --from-file=$TEMP_DIR/index.html \
        --from-file=$TEMP_DIR/styles.css \
        --from-file=$TEMP_DIR/script.js \
        -n hacker-site \
        --dry-run=client -o yaml | k3s kubectl apply -f -
    
    # Create Nginx configuration
    cat <<NGINX_EOF | k3s kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-config
  namespace: hacker-site
data:
  default.conf: |
    server {
        listen 80;
        server_name _;
        root /usr/share/nginx/html;
        index index.html;
        
        # Security headers
        add_header X-Frame-Options "SAMEORIGIN" always;
        add_header X-XSS-Protection "1; mode=block" always;
        add_header X-Content-Type-Options "nosniff" always;
        
        # Gzip compression
        gzip on;
        gzip_types text/plain text/css application/javascript text/xml application/xml text/javascript;
        
        location / {
            try_files \$uri \$uri/ =404;
        }
        
        # Cache static assets
        location ~* \.(css|js|png|jpg|jpeg|gif|ico|svg)$ {
            expires 1y;
            add_header Cache-Control "public, immutable";
        }
    }
NGINX_EOF
    
    # Cleanup
    rm -rf $TEMP_DIR
    
    print_success "Website content deployed!"
}

display_cluster_info() {
    print_status "Gathering cluster information..."
    
    echo
    echo "=================================="
    echo "🍓 K3s Cluster Setup Complete!"
    echo "=================================="
    echo "Cluster Name: $CLUSTER_NAME"
    echo "Domain: $DOMAIN"
    echo
    echo "Nodes:"
    k3s kubectl get nodes -o wide
    echo
    echo "Ingress IP:"
    INGRESS_IP=$(k3s kubectl get svc -n ingress-nginx ingress-nginx-controller -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
    echo "External IP: $INGRESS_IP"
    echo
    echo "DNS Configuration Needed:"
    echo "A Record: @ -> $INGRESS_IP"
    echo "A Record: www -> $INGRESS_IP"
    echo
    echo "Services:"
    k3s kubectl get svc -A
    echo
    echo "Website Status:"
    k3s kubectl get pods -n hacker-site
    echo
    echo "Access your site:"
    echo "- Local: http://$INGRESS_IP"
    echo "- Domain: https://$DOMAIN (after DNS setup)"
    echo "=================================="
}

main() {
    print_header
    
    NODE_TYPE=${1:-"master"}
    
    check_prerequisites
    setup_node $NODE_TYPE
    
    case $NODE_TYPE in
        "master"|"server")
            install_k3s_master
            sleep 10
            install_metallb
            install_nginx_ingress
            install_cert_manager
            create_website_content
            deploy_website
            display_cluster_info
            ;;
        "worker"|"agent")
            install_k3s_worker
            ;;
        *)
            print_error "Usage: $0 [master|worker]"
            exit 1
            ;;
    esac
    
    print_success "Setup completed! Reboot recommended to apply all changes."
}

main "$@"
