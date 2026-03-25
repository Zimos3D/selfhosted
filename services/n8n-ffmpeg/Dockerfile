# Start from the official n8n image specified in your compose file
FROM n8nio/n8n:alpine

# Install FFmpeg using Alpine's package manager (apk)
USER root

# Update packages and install ffmpeg
# The 'no-cache' option and removal of lists perform the same cleanup as before.
RUN apk update \
    && apk add --no-cache ffmpeg \
    && rm -rf /var/cache/apk/*

# Switch back to the non-root user (important for security)
USER node