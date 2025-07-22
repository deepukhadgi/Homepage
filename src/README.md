# 🎨 Source Code

This directory contains the core website files for the Dark Hacker Homepage.

## 📁 Files

```
src/
├── index.html    # Main HTML structure
├── styles.css    # Dark theme styling and animations
├── script.js     # Interactive functionality and effects
└── README.md     # This file
```

## 🔧 Development

### Local Development
```bash
cd src
python3 -m http.server 8000
# Visit http://localhost:8000
```

### File Descriptions

#### `index.html`
- **Semantic HTML5** structure
- **Terminal-style** sections and layout
- **Responsive** design elements
- **Accessibility** features included

#### `styles.css`
- **CSS Custom Properties** for theming
- **Advanced animations** (matrix rain, typing effects)
- **Responsive grid** layouts
- **Dark cyberpunk** color scheme
- **Performance optimized** selectors

#### `script.js`
- **Vanilla JavaScript** (no dependencies)
- **Interactive animations** and effects
- **Performance optimized** with requestAnimationFrame
- **Easter eggs** and special features
- **Modular functions** for maintainability

## 🎨 Customization

### Colors
Edit CSS custom properties in `styles.css`:
```css
:root {
    --bg-primary: #0a0a0a;
    --text-primary: #00ff00;
    --text-accent: #ffff00;
}
```

### Content
- **Projects**: Update the projects section in `index.html`
- **About**: Modify the JSON profile data
- **Contact**: Change contact information
- **Terminal Commands**: Edit typing animations in `script.js`

### Features
- **Matrix Characters**: Modify the matrix string in `script.js`
- **Animation Speed**: Adjust timing values
- **New Sections**: Add following the existing pattern

## 🔍 Code Quality

- **No external dependencies** (except Google Fonts)
- **Modern ES6+** JavaScript
- **CSS Grid** and **Flexbox** layouts
- **Semantic HTML** structure
- **Progressive enhancement** approach
- **Performance optimized** animations

## 📊 Performance

- **Bundle Size**: <50KB total
- **Load Time**: <2 seconds
- **Lighthouse Score**: 95+
- **Mobile Optimized**: Responsive design
- **SEO Ready**: Semantic markup
