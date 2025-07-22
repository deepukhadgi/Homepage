# Router Port Forwarding Setup Guide

To make your Raspberry Pi website accessible worldwide, you need to configure port forwarding on your router.

## Required Port Forwarding Rules

| Service | External Port | Internal Port | Internal IP | Protocol |
|---------|---------------|---------------|-------------|----------|
| HTTP    | 80           | 80            | [Pi IP]     | TCP      |
| HTTPS   | 443          | 443           | [Pi IP]     | TCP      |
| SSH     | 22           | 22            | [Pi IP]     | TCP      |

## Find Your Raspberry Pi's Local IP

Run this command on your Pi:
```bash
hostname -I | awk '{print $1}'
```

## Common Router Access Methods

1. **Web Interface**: Usually accessible at:
   - http://192.168.1.1
   - http://192.168.0.1
   - http://10.0.0.1

2. **Default Login Credentials** (check router label):
   - admin/admin
   - admin/password
   - admin/[blank]

## Router-Specific Guides

### Generic Steps:
1. Access router admin panel
2. Find "Port Forwarding" or "Virtual Server" section
3. Add new rule for HTTP (port 80)
4. Add new rule for HTTPS (port 443)
5. Set internal IP to your Pi's IP
6. Save and reboot router

### Popular Router Brands:
- **TP-Link**: Advanced → NAT Forwarding → Virtual Servers
- **Netgear**: Dynamic DNS → Port Forwarding
- **Linksys**: Smart Wi-Fi Tools → Port Range Forward
- **ASUS**: WAN → Virtual Server/Port Forwarding
- **D-Link**: Advanced → Port Forwarding

## Security Considerations

⚠️ **Important Security Notes:**
- Only forward necessary ports
- Use strong passwords for Pi user accounts
- Keep your Pi updated with: `sudo apt update && sudo apt upgrade`
- Consider changing SSH port from default 22
- Use fail2ban for additional security

## Testing Port Forwarding

After setup, test with:
```bash
# Check if ports are open (run from external network)
nmap -p 80,443 your-public-ip

# Or use online tools:
# https://www.yougetsignal.com/tools/open-ports/
```
