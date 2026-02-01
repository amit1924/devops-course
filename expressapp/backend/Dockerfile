# Step 1: Use Node image
FROM node:20

# Step 2: Set working directory
WORKDIR /app

# Step 3: Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Step 4: Copy source code
COPY . .

# Step 5: Expose port
EXPOSE 5000

# Step 6: Start server
CMD ["node", "server.js"]
