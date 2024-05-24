# syntax=docker/dockerfile:1

# Stage 1: Build the Rancher UI
FROM node:17-alpine as build-stage

# Create the app directory
RUN mkdir -p /rancher-ui

# Set the working directory
WORKDIR /rancher-ui

# Copy the package.json and yarn.lock files
COPY package.json ./
COPY yarn.lock ./

# Copy the source code
COPY pkg ./pkg
COPY shell ./shell

# Copy the configuration files
COPY .eslint* ./
COPY babel.config.js ./
COPY svgTransform.js ./
COPY tsconfig.json tsconfig.paths.json ./
COPY vue-shim.d.ts vue.config.js ./

# Install the dependencies
RUN yarn install

# Build the Rancher UI
# Make sure we use the proper SSL provider
RUN NODE_OPTIONS="--openssl-legacy-provider --max_old_space_size=4096" \
    ./node_modules/.bin/vue-cli-service build --mode production

# Copy the Nginx configuration
# We do this last to avoid invalidating the cache
COPY nginx ./nginx

# Stage 2: Serve the Rancher UI
FROM nginx:alpine

# Copy the Rancher UI build
COPY --from=build-stage /rancher-ui/nginx/templates/* /etc/nginx/templates/
COPY --from=build-stage /rancher-ui/dist /usr/share/nginx/html
