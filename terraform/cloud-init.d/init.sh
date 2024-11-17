#!/usr/bin/env bash
set -euo pipefail

# mount volume
while true; do
    directory=/dev/disk/by-id
    if [ ! -d "$directory" ]; then
        echo "Waiting for $directory..."
        sleep 10
    else
        break
    fi
done

while true; do
    volume_id=$(ls /dev/disk/by-id 2>/dev/null | grep "scsi-0HC_Volume")
    if [[ -z "$volume_id" ]]; then
        echo "Waiting for mountable volume..."
        sleep 10
    else
        break
    fi
done

echo "Mounting volume $volume_id"
mkdir -p /mnt/data
mount "/dev/disk/by-id/$volume_id" /mnt/data
echo "/dev/disk/by-id/$volume_id /mnt/data ext4 defaults 0 0" >> /etc/fstab

# update config
if [ -f /usr/local/bin/update-config ]; then
    /usr/local/bin/update-config
fi

# create docker-compose.yaml and run
cd /app
echo "${base64encode(docker_compose_file)}" | base64 -d > /app/docker-compose.yaml
chmod 0755 /app/docker-compose.yaml
docker-compose up -d
