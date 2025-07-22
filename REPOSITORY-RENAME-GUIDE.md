# 🔄 Repository Rename Guide

This guide helps you rename the repository from `cursor` to `terminal-nexus`.

## 🎯 **Recommended Name: `terminal-nexus`**

### Why This Name?
- ✅ **Professional** - Enterprise-ready branding
- ✅ **Descriptive** - Clearly indicates terminal/hacker theme
- ✅ **Memorable** - Easy to remember and share
- ✅ **SEO-Friendly** - Good for discoverability
- ✅ **Brandable** - Perfect for portfolio/resume

## 📋 **Step-by-Step Rename Process**

### Step 1: Rename on GitHub
1. Go to: `https://github.com/deepukhadgi/cursor`
2. Click **"Settings"** tab
3. Scroll to **"Repository name"** section
4. Change `cursor` to `terminal-nexus`
5. Click **"Rename"** button
6. Confirm the rename

### Step 2: Update Local Repository
```bash
# Run the provided script
./update-repository-name.sh
```

### Step 3: Update Documentation
The following files have been pre-updated with the new name:
- ✅ `README.md` - Updated title and URLs
- ✅ All documentation links
- ✅ Deployment script URLs
- ✅ Clone instructions

### Step 4: Update External References
After renaming, update:
- [ ] Bookmarks in your browser
- [ ] Any external documentation
- [ ] Portfolio/resume links
- [ ] Social media references
- [ ] Domain configuration (if using custom domain)

## 🌐 **New URLs After Rename**

| Service | Old URL | New URL |
|---------|---------|---------|
| Repository | `github.com/deepukhadgi/cursor` | `github.com/deepukhadgi/terminal-nexus` |
| Clone HTTPS | `https://github.com/deepukhadgi/cursor.git` | `https://github.com/deepukhadgi/terminal-nexus.git` |
| Clone SSH | `git@github.com:deepukhadgi/cursor.git` | `git@github.com:deepukhadgi/terminal-nexus.git` |
| Raw Files | `raw.githubusercontent.com/deepukhadgi/cursor/main/` | `raw.githubusercontent.com/deepukhadgi/terminal-nexus/main/` |

## 🚀 **Benefits of New Name**

### Professional Branding
- **Portfolio Ready** - Looks great on resume/portfolio
- **Memorable** - Easy for employers/collaborators to remember
- **Descriptive** - Clearly explains what the project does
- **Searchable** - Better SEO and discoverability

### Technical Benefits
- **Clearer Purpose** - Name matches the hacker/terminal theme
- **Brand Consistency** - Aligns with project aesthetics
- **Professional URLs** - Better for sharing and documentation

## ⚠️ **Important Notes**

### GitHub Redirects
- GitHub automatically redirects old URLs for a period
- Update bookmarks and references anyway
- Some services may cache old URLs

### Dependencies
- Check if any external services reference the old name
- Update webhooks, CI/CD pipelines, or integrations
- Verify deployment scripts still work

### Collaboration
- Notify collaborators about the name change
- Update team documentation
- Share new repository URL

## 🔧 **Troubleshooting**

### If Remote Update Fails
```bash
# Remove old remote
git remote remove origin

# Add new remote
git remote add origin https://github.com/deepukhadgi/terminal-nexus.git

# Verify
git remote -v
```

### If Push Fails
```bash
# Force fetch from new URL
git fetch origin

# Reset upstream branch
git branch --set-upstream-to=origin/main main
```

## ✅ **Verification Checklist**

After renaming:
- [ ] Repository accessible at new URL
- [ ] Local git remote updated
- [ ] Can push/pull successfully
- [ ] Documentation links work
- [ ] Deployment scripts reference correct URLs
- [ ] External references updated

## 🎉 **Completion**

Once renamed, your repository will have:
- ✅ **Professional name** that matches the project theme
- ✅ **Updated documentation** with correct URLs
- ✅ **Consistent branding** across all files
- ✅ **Better discoverability** for potential users/employers

**New Repository**: `https://github.com/deepukhadgi/terminal-nexus` 🚀
