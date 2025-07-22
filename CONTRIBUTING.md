# 🤝 Contributing to Dark Hacker Homepage

Thank you for your interest in contributing! This document provides guidelines and information for contributors.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Project Structure](#project-structure)
- [Contribution Guidelines](#contribution-guidelines)
- [Pull Request Process](#pull-request-process)
- [Issue Guidelines](#issue-guidelines)
- [Code Style](#code-style)
- [Testing](#testing)

## 📜 Code of Conduct

This project follows a simple code of conduct:
- Be respectful and inclusive
- Focus on constructive feedback
- Help maintain a positive environment
- Report unacceptable behavior

## 🚀 Getting Started

### Prerequisites
- Git installed
- Basic knowledge of HTML, CSS, JavaScript
- Text editor or IDE
- Web browser for testing

### Fork and Clone
```bash
# Fork the repository on GitHub, then:
git clone https://github.com/your-username/your-fork.git
cd your-fork

# Add upstream remote
git remote add upstream https://github.com/original-owner/original-repo.git
```

## 🛠️ Development Setup

### Local Development
```bash
# Navigate to source directory
cd src

# Start local server
python3 -m http.server 8000
# Or use any other local server

# Visit http://localhost:8000
```

### Testing Changes
```bash
# Test on different browsers
# Test responsive design
# Verify animations work smoothly
# Check console for errors
```

## 📁 Project Structure

```
├── src/                    # Website source code
├── deployment/             # Deployment scripts
│   ├── raspberry-pi/       # Single Pi deployment
│   └── k3s/               # Kubernetes deployment
├── scripts/               # Utility scripts
├── docs/                  # Documentation
│   ├── deployment/        # Deployment guides
│   └── guides/           # Configuration guides
└── configs/              # Configuration files
```

## 📝 Contribution Guidelines

### Types of Contributions

#### 🐛 Bug Reports
- Use the bug report template
- Include steps to reproduce
- Provide browser/OS information
- Add screenshots if helpful

#### ✨ Feature Requests
- Use the feature request template
- Explain the use case
- Consider implementation complexity
- Discuss alternatives

#### 🔧 Code Contributions
- Follow coding standards
- Add appropriate documentation
- Include tests if applicable
- Update README if needed

#### 📚 Documentation
- Fix typos and grammar
- Improve clarity
- Add missing information
- Update outdated content

### Areas for Contribution

#### Frontend (src/)
- **New animations**: Matrix effects, typing animations
- **Responsive design**: Mobile optimization
- **Accessibility**: ARIA labels, keyboard navigation
- **Performance**: Optimization, lazy loading
- **Browser compatibility**: Cross-browser testing

#### Deployment (deployment/)
- **New platforms**: Docker, AWS, Azure, GCP
- **Automation**: CI/CD pipelines
- **Monitoring**: Health checks, metrics
- **Security**: Hardening, best practices

#### Documentation (docs/)
- **Tutorials**: Step-by-step guides
- **Troubleshooting**: Common issues
- **Examples**: Configuration samples
- **Translations**: Multi-language support

## 🔄 Pull Request Process

### Before Submitting
1. **Check existing PRs** to avoid duplicates
2. **Test thoroughly** on multiple browsers
3. **Update documentation** if needed
4. **Follow code style** guidelines
5. **Keep changes focused** on single issue

### PR Guidelines
1. **Clear title** describing the change
2. **Detailed description** of what and why
3. **Link related issues** using keywords
4. **Add screenshots** for visual changes
5. **Update CHANGELOG** if significant

### PR Template
```markdown
## Description
Brief description of changes

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Performance improvement

## Testing
- [ ] Tested locally
- [ ] Cross-browser tested
- [ ] Mobile responsive checked

## Screenshots
(If applicable)

## Related Issues
Fixes #(issue number)
```

## 🐛 Issue Guidelines

### Bug Reports
```markdown
**Describe the bug**
Clear description of the issue

**To Reproduce**
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
What should happen

**Screenshots**
If applicable

**Environment:**
- OS: [e.g. iOS]
- Browser: [e.g. chrome, safari]
- Version: [e.g. 22]
```

### Feature Requests
```markdown
**Is your feature request related to a problem?**
Clear description of the problem

**Describe the solution you'd like**
Clear description of desired feature

**Describe alternatives you've considered**
Alternative solutions or features

**Additional context**
Any other context or screenshots
```

## 🎨 Code Style

### HTML
- Use semantic elements
- Include proper meta tags
- Add ARIA labels for accessibility
- Validate markup

### CSS
- Use CSS custom properties
- Follow BEM methodology
- Mobile-first approach
- Optimize for performance

### JavaScript
- Use modern ES6+ features
- Add JSDoc comments
- Handle errors gracefully
- Optimize for performance

### File Organization
- Keep files focused and modular
- Use descriptive naming
- Group related functionality
- Update documentation

## 🧪 Testing

### Manual Testing
- **Functionality**: All features work
- **Responsive**: Mobile, tablet, desktop
- **Cross-browser**: Chrome, Firefox, Safari, Edge
- **Performance**: Fast loading, smooth animations
- **Accessibility**: Screen readers, keyboard navigation

### Testing Checklist
- [ ] All animations work smoothly
- [ ] No console errors
- [ ] Mobile responsive
- [ ] Fast loading times
- [ ] Accessible navigation
- [ ] Cross-browser compatible

## 📚 Documentation

### Documentation Standards
- Use clear, concise language
- Include code examples
- Add screenshots for visual features
- Keep information up-to-date

### Documentation Types
- **README**: Project overview
- **Deployment guides**: Setup instructions
- **API documentation**: If applicable
- **Troubleshooting**: Common issues

## 🏷️ Release Process

### Versioning
We use [Semantic Versioning](https://semver.org/):
- **MAJOR**: Breaking changes
- **MINOR**: New features (backward compatible)
- **PATCH**: Bug fixes

### Release Notes
- List all changes
- Credit contributors
- Include migration guides if needed
- Highlight security updates

## 🙏 Recognition

Contributors will be:
- Listed in CONTRIBUTORS.md
- Mentioned in release notes
- Recognized for significant contributions

## 📞 Getting Help

- **Documentation**: Check docs/ directory
- **Issues**: Search existing issues
- **Community**: Engage with other contributors
- **Maintainers**: Contact project maintainers

## 🎯 Roadmap

Future development areas:
- Performance optimizations
- New deployment platforms
- Enhanced animations
- Accessibility improvements
- Mobile app version
- Progressive Web App features

Thank you for contributing! 🚀
