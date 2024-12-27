#!/usr/bin/env bash
set -euo pipefail

# Wait for volume to be mounted
while true; do
    mountpoint=$(findmnt -rno TARGET /mnt/HC_Volume_* || true)
    if [[ -z "$${mountpoint:-}" ]]; then
        echo "Waiting for volume to be mounted..."
        sleep 10
    else
        break
    fi
done

# Create symlink to mounted volume
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
