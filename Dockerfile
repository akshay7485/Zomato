# Use Node.js 16 slim as the base image
FROM node:16-slim

# Set the working directory
WORKDIR /app

# Set NPM registry to avoid network issues
RUN npm config set registry http://registry.npmjs.org/

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies with retry logic and fix potential network issues
RUN npm cache clean --force && \
    npm install --legacy-peer-deps --no-audit --no-fund

# Copy the rest of the application code
COPY . .

# Build the React app
RUN npm run build

# Expose port 3000 (or the port your app is configured to listen on)
EXPOSE 3000

# Start your Node.js server (assuming it serves the React app)  
CMD ["npm", "start"]
