# Use the n8n base image
FROM n8nio/n8n:latest

# Switch to root to install packages
USER root

# Install ffmpeg using apt (Debian/Ubuntu package manager)
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch back to the node user for security
USER node