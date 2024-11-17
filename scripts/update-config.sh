#!/usr/bin/env bash
set -euo pipefail

HERE=$(dirname "$0")
cd "${HERE}/.."

INSTANCE=$(hcloud server list -o columns=id -o noheader)

hcloud server ssh $INSTANCE \
    -o StrictHostKeyChecking=no \
    '/usr/local/bin/update-config'

echo "Run update-config successfully"
