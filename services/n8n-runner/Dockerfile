# STAGE 1: Get static FFmpeg (most reliable way for minimal images)
FROM mwader/static-ffmpeg:6.0 AS ffmpeg-source

# STAGE 2: Base n8n runner image
FROM docker.n8n.io/n8nio/runners:latest

USER root

# Install Python 3
# Note: In n8n v2 runners, we often need to bootstrap apk if it's missing, 
# but usually, 'runners' still has basic alpine tools.
RUN apk add --no-cache python3 py3-pip

# Copy FFmpeg and FFprobe from the static source
COPY --from=ffmpeg-source /ffmpeg /usr/local/bin/
COPY --from=ffmpeg-source /ffprobe /usr/local/bin/

# Ensure the runner user can execute them
RUN chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe

# Switch back to the non-root runner user
USER runner