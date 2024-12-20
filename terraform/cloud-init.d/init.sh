#!/usr/bin/env bash
set -euo pipefail

# Wait for volume to be mounted
sleep 20

while true; do
    mountpoint=$(mount | grep "HC_Volume" | awk '{print $3}')
    if [[ -z "$mountpoint" ]]; then
        echo "Waiting for mountpoint to be available..."
        sleep 10
    else
        break
    fi
done

# Create symlink to mounted volume
mkdir -p /mnt/data
ln -s $mountpoint /mnt/data

# update config
if [ -f /usr/local/bin/update-config ]; then
    /usr/local/bin/update-config
fi

# create docker-compose.yaml and run
cd /app
echo "${base64encode(docker_compose_file)}" | base64 -d > /app/docker-compose.yaml
chmod 0755 /app/docker-compose.yaml
docker-compose up -d
