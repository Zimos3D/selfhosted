# STAGE 1: Grab a pre-built, static version of ffmpeg
# Using mwader/static-ffmpeg because it's the gold standard for this
FROM mwader/static-ffmpeg:7.1 AS ffmpeg-source

# STAGE 2: Use the official n8n image (the one that was giving you trouble)
FROM n8nio/n8n:latest

# Switch to root to move the binary
USER root

# Copy the static ffmpeg and ffprobe binaries into n8n's path
COPY --from=ffmpeg-source /ffmpeg /usr/local/bin/ffmpeg
COPY --from=ffmpeg-source /ffprobe /usr/local/bin/ffprobe

# Ensure they are executable (just in case)
RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe

# Switch back to the 'node' user for security
USER node