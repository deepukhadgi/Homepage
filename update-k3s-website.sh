#!/bin/bash

# Update script for K3s deployed website
# This script updates the website content from GitHub

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

NAMESPACE="hacker-site"
REPO_URL="https://github.com/deepukhadgi/cursor.git"

print_status "Updating hacker homepage in K3s cluster..."

# Create temporary directory
TEMP_DIR=$(mktemp -d)

# Clone latest code
print_status "Fetching latest code from GitHub..."
git clone $REPO_URL $TEMP_DIR

# Update ConfigMap with new content
print_status "Updating website content ConfigMap..."
kubectl delete configmap website-content -n $NAMESPACE --ignore-not-found=true

kubectl create configmap website-content \
    --from-file=$TEMP_DIR/index.html \
    --from-file=$TEMP_DIR/styles.css \
    --from-file=$TEMP_DIR/script.js \
    -n $NAMESPACE

# Restart deployment to pick up changes
print_status "Rolling out updated deployment..."
kubectl rollout restart deployment/hacker-homepage -n $NAMESPACE

# Wait for rollout to complete
print_status "Waiting for deployment rollout to complete..."
kubectl rollout status deployment/hacker-homepage -n $NAMESPACE --timeout=300s

# Cleanup
rm -rf $TEMP_DIR

print_success "Website updated successfully!"

# Show current status
echo ""
echo "Current deployment status:"
kubectl get pods -n $NAMESPACE
echo ""
echo "Service status:"
kubectl get svc -n $NAMESPACE
echo ""
echo "Ingress status:"
kubectl get ingress -n $NAMESPACE
