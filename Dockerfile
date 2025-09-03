# Use an older Node.js version (e.g. Node 12, which is EOL and potentially vulnerable)
FROM node:12

# Create app directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies (some may be outdated/vulnerable)
RUN npm install

# Copy the rest of the app
COPY . .

# Expose the app port
EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
