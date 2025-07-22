# DNS Setup Guide for deepukhadgi.com.np

## Step 1: Find Your Public IP Address

Run this on your Raspberry Pi:
```bash
curl ifconfig.me
```

## Step 2: DNS Records Configuration

Add these DNS records at your domain registrar:

### Required DNS Records:
```
Type: A
Name: @
Value: [Your Public IP]
TTL: 3600

Type: A  
Name: www
Value: [Your Public IP]
TTL: 3600
```

### Optional Records:
```
Type: CNAME
Name: blog
Value: deepukhadgi.com.np
TTL: 3600

Type: CNAME
Name: api
Value: deepukhadgi.com.np
TTL: 3600
```

## Step 3: Nepal Domain (.com.np) Specific Instructions

Since you're using a .com.np domain, you'll need to:

1. **Login to your domain registrar** (likely Mercantile Communications or other .np provider)
2. **Find DNS Management** section
3. **Add the A records** as shown above
4. **Wait for propagation** (can take 24-48 hours)

## Step 4: Verify DNS Propagation

Use these tools to check if DNS is working:

### Command Line:
```bash
# Check A record
dig deepukhadgi.com.np A

# Check WWW record  
dig www.deepukhadgi.com.np A

# Check from different DNS servers
nslookup deepukhadgi.com.np 8.8.8.8
nslookup deepukhadgi.com.np 1.1.1.1
```

### Online Tools:
- https://www.whatsmydns.net/
- https://dnschecker.org/
- https://www.dnswatch.info/

## Step 5: Dynamic DNS (Optional)

If your ISP changes your IP address frequently, consider:

### Free Dynamic DNS Services:
- **No-IP**: https://www.noip.com/
- **DuckDNS**: https://www.duckdns.org/
- **FreeDNS**: https://freedns.afraid.org/

### Install Dynamic DNS Client on Pi:
```bash
# For No-IP
sudo apt install noip2
sudo noip2 -C  # Configure

# For DuckDNS  
echo 'echo url="https://www.duckdns.org/update?domains=yourdomain&token=yourtoken&ip=" | curl -k -o ~/duckdns/duck.log -K -' > ~/duckdns/duck.sh
chmod +x ~/duckdns/duck.sh
```

### Add to Crontab for Auto-Update:
```bash
crontab -e
# Add line:
*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1
```

## Troubleshooting

### DNS Not Resolving:
1. **Check TTL**: Wait for TTL period to expire
2. **Flush DNS**: `sudo systemctl flush-dns` (on Pi)
3. **Try Different DNS**: Use 8.8.8.8 or 1.1.1.1
4. **Check Syntax**: Ensure no typos in DNS records

### Still Not Working:
1. **Verify Public IP**: Make sure it's correct
2. **Check Port Forwarding**: Ensure router is configured
3. **Test Locally**: Visit http://[local-pi-ip] first
4. **Check Firewall**: Ensure Pi firewall allows traffic

## Expected Timeline:
- **Local Testing**: Immediate
- **DNS Propagation**: 1-24 hours
- **Full Global Propagation**: 24-48 hours

Once DNS is working, your site will be accessible at:
- http://deepukhadgi.com.np
- https://deepukhadgi.com.np (after SSL setup)
