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

# https://github.com/rancher/dashboard/blob/master/docs/developer/build-methods/build-for-container-registry.md
FROM rancher/rancher:v2.8-head
WORKDIR /var/lib/rancher

RUN rm -rf /usr/share/rancher-ui/ui-dashboard/dashboard*
COPY --from=build-stage /rancher-ui/dist /usr/share/rancher/ui-dashboard/dashboard
