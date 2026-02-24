# Use official Node.js LTS (as of 2026, node:20 or node:22 slim)
FROM node:20-slim

# Set working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy the rest of the app
COPY . .

# Preprocess (required by the bundler)
RUN yarn preprocess

# Optional: Deploy contracts if needed for testing (but usually do this externally or via entrypoint)
# RUN yarn hardhat-deploy --network localhost   # <- comment out unless running a full local stack

# Expose the bundler RPC port (default is 3000)
EXPOSE 3000

# Run the bundler (adjust flags as needed, e.g. --port, --rpc, --entryPoint, etc.)
# Use --unsafe for local/dev testing without full validation
CMD ["yarn", "run", "bundler"]
# Or for production-like: CMD ["yarn", "run", "bundler", "--http", "--port", "3000"]
