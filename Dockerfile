# Use Docker BuildKit syntax to enable secret mounting
#syntax=docker/dockerfile:1

# Pull the base image from your Artifactory Docker repository
FROM harryv1.jfrog.io/harryv-docker/node:18-alpine

# Set the working directory in the container to /app
WORKDIR /app

# Copy package.json and package-lock.json first for better layer caching
COPY package*.json ./

# Run npm install, mounting the secret .npmrc file to resolve from Artifactory
# The secret is only available during this command and is not saved in the image.
RUN --mount=type=secret,id=npmrc,target=/root/.npmrc npm install

# Copy the rest of the application source code
COPY . .

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Run app.js when the container launches
CMD ["node", "app.js"]

