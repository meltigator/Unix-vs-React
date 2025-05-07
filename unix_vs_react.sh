#!/usr/bin/env bash
# Script to create a simple React demo without complex build tools
# written by Andrea Giani
#

set -e

# Set variables
APP_NAME="unix-vs-react-simple"
echo "==> Creating simple React demo: $APP_NAME"

# Clean previous attempt
rm -rf "$APP_NAME"  # <-- Aggiunta cruciale per MSYS2/Windows
mkdir -p "$APP_NAME" && cd "$APP_NAME"

# Create base structure
mkdir -p js css

# Create index.html
cat > index.html <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Unix vs React - Simple Demo</title>
  <link rel="stylesheet" href="css/style.css">
  
  <!-- Load React from CDN -->
  <script src="https://unpkg.com/react@18/umd/react.development.js" crossorigin></script>
  <script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js" crossorigin></script>
  <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
</head>
<body>
  <div id="root"></div>
  
  <!-- React script with Babel for JSX -->
  <script type="text/babel" src="js/app.js"></script>
</body>
</html>
EOF

cat > css/style.css <<'EOF'
:root {
  --primary: #2563eb;
  --secondary: #4f46e5;
  --accent: #f59e0b;
  --dark: #1e293b;
  --light: #f8fafc;
}

body {
  font-family: 'Segoe UI', system-ui, sans-serif;
  margin: 0;
  padding: 0;
  background: linear-gradient(135deg, #f3f4f6 0%, #e5e7eb 100%);
  min-height: 100vh;
}

.container {
  max-width: 800px;
  margin: 2rem auto;
  padding: 2.5rem;
  background: rgba(255, 255, 255, 0.95);
  border-radius: 1rem;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  text-align: center;
}

.header {
  margin-bottom: 2rem;
}

.title {
  color: var(--dark);
  font-size: 2.5rem;
  margin: 0 0 1rem;
  background: linear-gradient(45deg, var(--primary), var(--secondary));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.feature-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1.5rem;
  margin: 2rem 0;
}

.feature-card {
  padding: 1.5rem;
  background: var(--light);
  border-radius: 0.75rem;
  transition: transform 0.2s, box-shadow 0.2s;
}

.feature-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}

.icon {
  font-size: 2rem;
  margin-bottom: 1rem;
  color: var(--primary);
}

.cta-button {
  background: linear-gradient(45deg, var(--primary), var(--secondary));
  color: white;
  border: none;
  padding: 1rem 2rem;
  font-size: 1.1rem;
  border-radius: 0.5rem;
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  font-weight: 600;
}

.cta-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
}

.commands-section {
  margin-top: 2rem;
  background: rgba(241, 245, 249, 0.8);
  border-radius: 0.75rem;
  padding: 1.5rem;
  border: 1px solid rgba(203, 213, 225, 0.3);
}

.footer {
  margin-top: 3rem;
  color: #64748b;
  font-size: 0.9rem;
}

/* Resto dello stile invariato... */
EOF

# Create main React component
cat > js/app.js <<'EOF'
// Component with useState hook for state management
function App() {
  const [counter, setCounter] = React.useState(0);
  const [showCommands, setShowCommands] = React.useState(false);
  
  // Function to increment counter
  const incrementCounter = () => {
    setCounter(counter + 1);
  };
  
  // Function to toggle Unix commands visibility
  const toggleCommands = () => {
    setShowCommands(!showCommands);
  };
  
  return (
    <div className="container">
      <h1>🧠 Unix vs React</h1>
      <div>
        <span className="badge">React 18</span>
        <span className="badge">Unix</span>
        <span className="badge">Bash</span>
      </div>
      <p>Demo of React configured entirely with Bash!</p>
      
      <button onClick={incrementCounter}>
        You clicked {counter} times
      </button>
      
      <p style={{marginTop: '20px'}}>
        <a href="#" onClick={toggleCommands}>
          {showCommands ? 'Hide' : 'Show'} used Unix commands
        </a>
      </p>
      
      {showCommands && (
        <div className="unix-commands">
          <h3>Used Unix commands:</h3>
          <code>mkdir -p js css</code>
          <code>cat > index.html ...</code>
          <code>cat > css/style.css ...</code>
          <code>cat > js/app.js ...</code>
          <code>python -m http.server</code>
        </div>
      )}
    </div>
  );
}

// Mount React app
const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
EOF

# Create README.md
cat > README.md <<EOF
# Unix vs React - Simple Demo

Minimalist React demo created entirely with bash scripts, without complex build tools.

## Features
- React 18 loaded from CDN
- Basic stateful component (hooks)
- Custom CSS styles
- No npm or Node.js dependency
- Runnable with any simple web server

## Getting Started
\`\`\`bash
cd $APP_NAME

# Option 1: Use Python to start web server
python3 -m http.server 8000 --directory ./

# Option 2: Use PHP
php -S localhost:8000

# Option 3: Open index.html directly in browser
\`\`\`

Created as an exercise for an interview with InRebus Technologies.
EOF

# Start HTTP server with explicit directory
echo "==> Setup complete! Trying to start a simple web server..."
echo "==> Visit http://localhost:8000/index.html in your browser"

if command -v python3 &> /dev/null; then
    echo "==> Starting server with Python 3..."
    python3 -m http.server 8000 --directory ./
elif command -v python &> /dev/null; then
    echo "==> Starting server with Python..."
    python -m http.server 8000 --directory ./
elif command -v php &> /dev/null; then
    echo "==> Starting server with PHP..."
    php -S localhost:8000 -t ./
else
    echo "==> Could not find Python or PHP to start server."
    echo "==> To view the demo, open index.html in your browser:"
    echo "==> $PWD/index.html"
fi