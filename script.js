// Typing animation for logo
const logoText = document.getElementById('logo-text');
const logoMessages = ['./hacker-hub', 'whoami', 'access_granted'];
let logoIndex = 0;

function typeLogo() {
    const message = logoMessages[logoIndex];
    logoText.textContent = '';
    let charIndex = 0;
    
    const typeChar = () => {
        if (charIndex < message.length) {
            logoText.textContent += message[charIndex];
            charIndex++;
            setTimeout(typeChar, 100);
        } else {
            setTimeout(() => {
                logoIndex = (logoIndex + 1) % logoMessages.length;
                typeLogo();
            }, 2000);
        }
    };
    
    typeChar();
}

// Terminal typing animation
const mainText = document.getElementById('main-text');
const terminalMessages = [
    'Elite hacker at your service...',
    'Bypassing firewall... [OK]',
    'Decrypting mainframe... [OK]',
    'Access level: MAXIMUM',
    'Welcome to the digital underground.'
];

let terminalIndex = 0;

function typeTerminal() {
    const message = terminalMessages[terminalIndex];
    mainText.textContent = '';
    let charIndex = 0;
    
    const typeChar = () => {
        if (charIndex < message.length) {
            mainText.textContent += message[charIndex];
            charIndex++;
            setTimeout(typeChar, 50);
        } else {
            setTimeout(() => {
                terminalIndex = (terminalIndex + 1) % terminalMessages.length;
                typeTerminal();
            }, 3000);
        }
    };
    
    typeChar();
}

// System stats animation
function updateStats() {
    const cpuUsage = document.getElementById('cpu-usage');
    const memoryUsage = document.getElementById('memory-usage');
    const cpuBar = document.getElementById('cpu-bar');
    const memoryBar = document.getElementById('memory-bar');
    
    // Generate random but realistic values
    const cpu = Math.floor(Math.random() * 40) + 30; // 30-70%
    const memory = Math.floor(Math.random() * 30) + 50; // 50-80%
    
    cpuUsage.textContent = cpu;
    memoryUsage.textContent = memory;
    cpuBar.style.width = cpu + '%';
    memoryBar.style.width = memory + '%';
}

// Uptime counter
function updateUptime() {
    const uptimeElement = document.getElementById('uptime');
    const startTime = new Date().getTime();
    
    setInterval(() => {
        const now = new Date().getTime();
        const uptime = now - startTime;
        
        const hours = Math.floor(uptime / (1000 * 60 * 60));
        const minutes = Math.floor((uptime % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((uptime % (1000 * 60)) / 1000);
        
        uptimeElement.textContent = 
            `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
    }, 1000);
}

// Matrix rain effect
function createMatrixRain() {
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');
    
    canvas.style.position = 'fixed';
    canvas.style.top = '0';
    canvas.style.left = '0';
    canvas.style.zIndex = '-1';
    canvas.style.opacity = '0.1';
    canvas.style.pointerEvents = 'none';
    
    document.body.appendChild(canvas);
    
    function resizeCanvas() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    }
    
    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);
    
    const matrix = "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789@#$%^&*()*&^%+-/~{[|`]}";
    const matrixArray = matrix.split("");
    
    const fontSize = 10;
    const columns = canvas.width / fontSize;
    
    const drops = [];
    for (let x = 0; x < columns; x++) {
        drops[x] = 1;
    }
    
    function draw() {
        ctx.fillStyle = 'rgba(0, 0, 0, 0.04)';
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        
        ctx.fillStyle = '#00ff00';
        ctx.font = fontSize + 'px monospace';
        
        for (let i = 0; i < drops.length; i++) {
            const text = matrixArray[Math.floor(Math.random() * matrixArray.length)];
            ctx.fillText(text, i * fontSize, drops[i] * fontSize);
            
            if (drops[i] * fontSize > canvas.height && Math.random() > 0.975) {
                drops[i] = 0;
            }
            
            drops[i]++;
        }
    }
    
    setInterval(draw, 35);
}

// Smooth scrolling for navigation
function initSmoothScrolling() {
    const navLinks = document.querySelectorAll('.nav-link');
    
    navLinks.forEach(link => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            const targetId = link.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                targetElement.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

// Terminal command simulation
function initTerminalCommands() {
    const terminalBody = document.querySelector('.terminal-body');
    let commandHistory = [];
    
    document.addEventListener('keydown', (e) => {
        // Simulate typing in terminal when user types
        if (e.key.length === 1 && Math.random() > 0.7) {
            const newLine = document.createElement('div');
            newLine.className = 'terminal-line';
            newLine.innerHTML = `<span class="prompt">visitor@system:~$</span> <span class="command">${e.key}</span>`;
            
            // Remove if too many lines
            const lines = terminalBody.querySelectorAll('.terminal-line');
            if (lines.length > 10) {
                lines[0].remove();
            }
        }
    });
}

// Project card hover effects
function initProjectCards() {
    const projectCards = document.querySelectorAll('.project-card');
    
    projectCards.forEach(card => {
        card.addEventListener('mouseenter', () => {
            card.style.borderColor = '#00ff00';
            card.style.boxShadow = '0 0 20px rgba(0, 255, 0, 0.3)';
        });
        
        card.addEventListener('mouseleave', () => {
            card.style.borderColor = '#333333';
            card.style.boxShadow = '0 10px 30px rgba(0, 255, 0, 0.1)';
        });
    });
}

// Konami code easter egg
function initKonamiCode() {
    const konamiCode = [
        'ArrowUp', 'ArrowUp', 'ArrowDown', 'ArrowDown',
        'ArrowLeft', 'ArrowRight', 'ArrowLeft', 'ArrowRight',
        'KeyB', 'KeyA'
    ];
    let konamiIndex = 0;
    
    document.addEventListener('keydown', (e) => {
        if (e.code === konamiCode[konamiIndex]) {
            konamiIndex++;
            if (konamiIndex === konamiCode.length) {
                // Easter egg triggered
                document.body.style.animation = 'glitch 0.5s infinite';
                setTimeout(() => {
                    document.body.style.animation = '';
                    konamiIndex = 0;
                }, 3000);
                
                // Show secret message
                const secretMsg = document.createElement('div');
                secretMsg.textContent = 'ACCESS LEVEL: GOD MODE ACTIVATED';
                secretMsg.style.cssText = `
                    position: fixed;
                    top: 50%;
                    left: 50%;
                    transform: translate(-50%, -50%);
                    background: rgba(0, 0, 0, 0.9);
                    color: #00ff00;
                    padding: 20px;
                    border: 2px solid #00ff00;
                    font-family: 'Fira Code', monospace;
                    font-size: 24px;
                    z-index: 9999;
                    text-shadow: 0 0 10px #00ff00;
                `;
                document.body.appendChild(secretMsg);
                
                setTimeout(() => {
                    secretMsg.remove();
                }, 3000);
            }
        } else {
            konamiIndex = 0;
        }
    });
}

// Random glitch effects
function initGlitchEffects() {
    const glitchElements = document.querySelectorAll('.section-title');
    
    setInterval(() => {
        const randomElement = glitchElements[Math.floor(Math.random() * glitchElements.length)];
        if (Math.random() > 0.95) {
            randomElement.style.animation = 'glitch 0.5s ease-in-out';
            setTimeout(() => {
                randomElement.style.animation = '';
            }, 500);
        }
    }, 2000);
}

// Initialize everything when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    // Start animations
    typeLogo();
    setTimeout(typeTerminal, 1000);
    updateUptime();
    
    // Update stats every 2 seconds
    setInterval(updateStats, 2000);
    updateStats();
    
    // Initialize interactive features
    createMatrixRain();
    initSmoothScrolling();
    initTerminalCommands();
    initProjectCards();
    initKonamiCode();
    initGlitchEffects();
    
    // Console message for fellow hackers
    console.log(`
    ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗ 
    ██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
    ███████║███████║██║     █████╔╝ █████╗  ██████╔╝
    ██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
    ██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║
    ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
    
    Welcome to the source, fellow hacker.
    Try the Konami code for a surprise: ↑↑↓↓←→←→BA
    `);
});

// Particle system for background
function initParticleSystem() {
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');
    
    canvas.style.position = 'fixed';
    canvas.style.top = '0';
    canvas.style.left = '0';
    canvas.style.zIndex = '-2';
    canvas.style.opacity = '0.3';
    canvas.style.pointerEvents = 'none';
    
    document.body.appendChild(canvas);
    
    function resizeCanvas() {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    }
    
    resizeCanvas();
    window.addEventListener('resize', resizeCanvas);
    
    const particles = [];
    const particleCount = 50;
    
    for (let i = 0; i < particleCount; i++) {
        particles.push({
            x: Math.random() * canvas.width,
            y: Math.random() * canvas.height,
            vx: (Math.random() - 0.5) * 0.5,
            vy: (Math.random() - 0.5) * 0.5,
            size: Math.random() * 2 + 1
        });
    }
    
    function drawParticles() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        ctx.fillStyle = '#00ff00';
        
        particles.forEach(particle => {
            ctx.beginPath();
            ctx.arc(particle.x, particle.y, particle.size, 0, Math.PI * 2);
            ctx.fill();
            
            particle.x += particle.vx;
            particle.y += particle.vy;
            
            if (particle.x < 0 || particle.x > canvas.width) particle.vx *= -1;
            if (particle.y < 0 || particle.y > canvas.height) particle.vy *= -1;
        });
    }
    
    setInterval(drawParticles, 50);
}

// Add particle system to initialization
document.addEventListener('DOMContentLoaded', () => {
    setTimeout(initParticleSystem, 1000);
});
