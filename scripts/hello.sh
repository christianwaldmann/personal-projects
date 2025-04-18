#!/usr/bin/env bash
set -euo pipefail

HERE=$(dirname "$0")
cd "${HERE}/../terraform"

if [ -z "${HCLOUD_TOKEN:-}" ]; then
  echo >&2 "Error: HCLOUD_TOKEN is not set. Please export it before running this script."
  exit 1
fi

export TF_VAR_hcloud_token=${HCLOUD_TOKEN}
export TF_VAR_hcloud_dns_token=def
export TF_VAR_ssh_public_key=xyz

echo "hello from script"
terraform "$@"