# 🔧 Scripts

Utility scripts for maintaining and updating the Dark Hacker Homepage.

## 📁 Scripts Available

```
scripts/
├── update-k3s-website.sh    # Update website in K3s cluster
└── README.md               # This file
```

## 📜 Script Details

### `update-k3s-website.sh`
**Purpose**: Updates the website content in a K3s cluster deployment

**Features**:
- Fetches latest code from GitHub
- Updates Kubernetes ConfigMaps
- Performs rolling deployment restart
- Zero-downtime updates
- Status verification

**Usage**:
```bash
./scripts/update-k3s-website.sh
```

**Requirements**:
- kubectl configured for your cluster
- Access to the hacker-site namespace
- Git installed on the system

**What it does**:
1. Creates temporary directory
2. Clones latest repository code
3. Updates website-content ConfigMap
4. Triggers rolling restart of deployment
5. Waits for rollout completion
6. Shows current deployment status

## 🔄 Automatic Updates

### Raspberry Pi
For Raspberry Pi deployments, the update script is installed during setup:
```bash
sudo /usr/local/bin/update-website.sh
```

### K3s Cluster
Use the script in this directory:
```bash
./scripts/update-k3s-website.sh
```

## 🚀 Future Scripts

Planned additional scripts:
- **backup-k3s.sh** - Backup cluster configuration
- **monitor-health.sh** - Health check automation
- **update-raspberry-pi.sh** - Update single Pi deployment
- **security-scan.sh** - Security assessment script

## 🔒 Security Notes

- Scripts require appropriate permissions
- Always review scripts before execution
- Test in development environment first
- Keep scripts updated with latest security practices

## 🆘 Troubleshooting

### Common Issues

#### Permission Denied
```bash
chmod +x scripts/script-name.sh
```

#### kubectl Not Found
```bash
# For K3s installations
alias kubectl="k3s kubectl"
```

#### Git Clone Fails
- Check network connectivity
- Verify repository access
- Ensure Git is installed

#### ConfigMap Update Fails
- Verify namespace exists
- Check kubectl permissions
- Ensure cluster connectivity
