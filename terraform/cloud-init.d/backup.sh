#!/usr/bin/env bash
set -euo pipefail

set -a
export $(grep "STORAGEBOX" /app/.env | xargs)
set +a

rsync \
  -e "ssh -p 23 -i /root/.ssh/storagebox -o StrictHostKeyChecking=no" \
  --recursive \
  --delete \
  /mnt/data/ \
  "$${STORAGEBOX_USERNAME}"@"$${STORAGEBOX_HOSTNAME}":/home/backups/personal-projects
