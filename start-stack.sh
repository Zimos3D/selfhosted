#!/bin/bash

# Wait for NVMe to be mounted
while [ ! -d /mnt/nvme-linux ]; do
    echo "Waiting for NVMe to be mounted..."
    sleep 2
done

# Try to pull latest from GitHub (graceful failure)
cd /mnt/e/selfhosted
if git pull --rebase origin main 2>&1 | tee /tmp/git-pull.log; then
    echo "$(date): Successfully pulled latest compose files" >> /var/log/docker-startup.log
else
    echo "$(date): GitHub pull failed, continuing with existing files" >> /var/log/docker-startup.log
fi

# Wait for Docker
while ! docker info >/dev/null 2>&1; do
    echo "Waiting for Docker to be ready..."
    sleep 3
done

# Start services with WSL environment file
docker-compose -f docker-compose.yml --env-file .env.wsl up -d