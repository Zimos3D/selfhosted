#!/bin/bash

# Wait until Docker is responsive
while ! docker info >/dev/null 2>&1; do
    echo "Waiting for Docker to be ready..."
    sleep 3
done

cd /mnt/e/selfhosted
docker-compose up -d
