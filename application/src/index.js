const http = require('http');
const port = process.env.PORT || 3000;

// Simulate readiness (for example, after some async init)
let isReady = true; // Set to false initially if needed

const server = http.createServer((req, res) => {
  if (req.url === '/health') {
    // Liveness probe
    res.statusCode = 200;
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify({ status: 'alive' }));
  } else if (req.url === '/ready') {
    // Readiness probe
    res.statusCode = isReady ? 200 : 503;
    res.setHeader('Content-Type', 'application/json');
    res.end(JSON.stringify({ status: isReady ? 'ready' : 'not ready' }));
  } else {
    // Default route
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end('Hello Node!\n');
  }
});

server.listen(port, () => {
  console.log(`Server running on http://0.0.0.0:${port}/`);
});

