#!/bin/bash

# Repository Name Update Script
# Run this after renaming the repository on GitHub

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

OLD_NAME="cursor"
NEW_NAME="terminal-nexus"
USERNAME="deepukhadgi"

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

echo "========================================"
echo "🔄 Repository Name Update Script"
echo "========================================"
echo "Old name: $OLD_NAME"
echo "New name: $NEW_NAME"
echo "Username: $USERNAME"
echo "========================================"

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a git repository"
    exit 1
fi

# Show current remote
print_status "Current remote configuration:"
git remote -v

# Update remote URL
print_status "Updating remote URL..."
NEW_URL="https://github.com/$USERNAME/$NEW_NAME.git"

# Update origin remote
git remote set-url origin $NEW_URL

print_success "Remote URL updated!"

# Verify the change
print_status "New remote configuration:"
git remote -v

# Test connection
print_status "Testing connection to new repository..."
if git ls-remote origin > /dev/null 2>&1; then
    print_success "✅ Connection successful!"
else
    print_warning "⚠️  Connection test failed. Make sure you've renamed the repository on GitHub."
fi

echo "========================================"
echo "🎉 Repository name update complete!"
echo "========================================"
echo "Next steps:"
echo "1. Rename repository on GitHub to: $NEW_NAME"
echo "2. Run this script: ./update-repository-name.sh"
echo "3. Update any documentation with new URLs"
echo "4. Update any bookmarks or external references"
