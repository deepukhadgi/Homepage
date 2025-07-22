#!/bin/bash

# K3s Monitoring Setup Script
# Installs Prometheus, Grafana, and monitoring dashboard

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Install Helm
install_helm() {
    print_status "Installing Helm..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    print_success "Helm installed successfully!"
}

# Install Prometheus Stack
install_prometheus() {
    print_status "Installing Prometheus monitoring stack..."
    
    # Add Prometheus Helm repository
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo update
    
    # Create monitoring namespace
    kubectl create namespace monitoring || true
    
    # Generate secure random password
    GRAFANA_PASSWORD=$(openssl rand -base64 12)
    echo "Generated Grafana password: $GRAFANA_PASSWORD"
    echo "IMPORTANT: Save this password securely!"
    
    # Install Prometheus stack
    helm install prometheus prometheus-community/kube-prometheus-stack \
        --namespace monitoring \
        --set prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.resources.requests.storage=2Gi \
        --set grafana.persistence.enabled=true \
        --set grafana.persistence.size=1Gi \
        --set alertmanager.alertmanagerSpec.storage.volumeClaimTemplate.spec.resources.requests.storage=1Gi \
        --set grafana.adminPassword=$GRAFANA_PASSWORD \
        --wait
    
    print_success "Prometheus stack installed!"
}

# Expose Grafana
expose_grafana() {
    print_status "Exposing Grafana dashboard..."
    
    cat <<GRAFANA_EOF | kubectl apply -f -
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: grafana-ingress
  namespace: monitoring
  annotations:
    nginx.ingress.kubernetes.io/auth-type: basic
    nginx.ingress.kubernetes.io/auth-secret: grafana-auth
    nginx.ingress.kubernetes.io/auth-realm: 'Authentication Required'
spec:
  ingressClassName: nginx
  rules:
  - host: monitoring.deepukhadgi.com.np
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: prometheus-grafana
            port:
              number: 80
GRAFANA_EOF
    
    # Create basic auth secret with secure password
    htpasswd -cb /tmp/auth admin $GRAFANA_PASSWORD
    kubectl create secret generic grafana-auth \
        --from-file=/tmp/auth \
        -n monitoring \
        --dry-run=client -o yaml | kubectl apply -f -
    rm /tmp/auth
    
    print_success "Grafana exposed at monitoring.your-domain.com"
    print_status "Username: admin, Password: $GRAFANA_PASSWORD"
}

# Install custom dashboards
install_dashboards() {
    print_status "Installing custom dashboards..."
    
    # Raspberry Pi dashboard
    cat <<DASHBOARD_EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: raspberry-pi-dashboard
  namespace: monitoring
  labels:
    grafana_dashboard: "1"
data:
  raspberry-pi.json: |
    {
      "dashboard": {
        "id": null,
        "title": "Raspberry Pi Cluster",
        "tags": ["raspberry-pi", "k3s"],
        "timezone": "browser",
        "panels": [
          {
            "title": "CPU Usage",
            "type": "stat",
            "targets": [
              {
                "expr": "100 - (avg(rate(node_cpu_seconds_total{mode=\"idle\"}[5m])) * 100)"
              }
            ]
          },
          {
            "title": "Memory Usage",
            "type": "stat",
            "targets": [
              {
                "expr": "(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100"
              }
            ]
          }
        ],
        "time": {
          "from": "now-1h",
          "to": "now"
        },
        "refresh": "5s"
      }
    }
DASHBOARD_EOF
    
    print_success "Custom dashboards installed!"
}

# Main function
main() {
    print_status "Setting up monitoring for K3s cluster..."
    
    # Check if kubectl is available
    if ! command -v kubectl &> /dev/null; then
        print_warning "kubectl not found, using k3s kubectl"
        alias kubectl="k3s kubectl"
    fi
    
    install_helm
    install_prometheus
    expose_grafana
    install_dashboards
    
    print_success "Monitoring setup complete!"
    
    echo ""
    echo "=================================="
    echo "🎯 Monitoring Stack Installed!"
    echo "=================================="
    echo "Grafana: https://monitoring.your-domain.com"
    echo "Username: admin"
    echo "Password: $GRAFANA_PASSWORD"
    echo ""
    echo "Prometheus: http://CLUSTER_IP:9090"
    echo "AlertManager: http://CLUSTER_IP:9093"
    echo ""
    echo "IMPORTANT: Save the Grafana password securely!"
    echo "Don't forget to add DNS record:"
    echo "monitoring.your-domain.com -> LoadBalancer IP"
    echo "=================================="
}

main "$@"
