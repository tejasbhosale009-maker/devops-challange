# -------------------
# Stage 1: Build Stage
# -------------------
FROM node:22-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies first (better caching)
COPY package*.json ./

RUN npm cache clean --force

RUN npm ci

# Copy application source
COPY . .

# Optional: Run tests (uncomment if needed)
# RUN npm test

# -------------------
# Stage 2: Runtime Stage
# -------------------
FROM node:22-alpine AS runtime

# Security: Add a non-root user
RUN addgroup -S nodejs && adduser -S nodejs -G nodejs

# Set working directory
WORKDIR /app

# Copy only the built app + dependencies from builder
COPY --from=builder /app /app

# Ensure ownership for non-root user
RUN chown -R nodejs:nodejs /app

# Switch to non-root
USER nodejs

# Expose application port
EXPOSE 3000

# Start the app
CMD ["node", "src/index.js"]
