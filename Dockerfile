# Stage 1: Build the Angular app
FROM node:18-alpine AS build

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install --silent

# Copy project files and build
COPY . .
RUN npm run build --prod

# Stage 2: Serve with a lightweight web server
FROM nginx:alpine

# Copy built Angular files to NGINX
COPY --from=build /app/dist/github-action /usr/share/nginx/html

# Expose port and start NGINX
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
