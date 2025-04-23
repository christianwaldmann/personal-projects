#!/usr/bin/env bash
set -euo pipefail

HERE=$(dirname "$0")
cd "${HERE}/../terraform"

if [ -z "${HCLOUD_TOKEN:-}" ]; then
  echo >&2 "Error: HCLOUD_TOKEN is not set. Please export it before running this script."
  exit 1
fi

if [ -z "${HCLOUD_DNS_TOKEN:-}" ]; then
  echo >&2 "Error: HCLOUD_DNS_TOKEN is not set. Please export it before running this script."
  exit 1
fi

if [ -z "${SSH_PUBLIC_KEY:-}" ]; then
  echo >&2 "Error: SSH_PUBLIC_KEY is not set. Please export it before running this script."
  exit 1
fi

if [ -z "${STORAGEBOX_SSH_PRIVATE_KEY:-}" ]; then
  echo >&2 "Error: STORAGEBOX_SSH_PRIVATE_KEY is not set. Please export it before running this script."
  exit 1
fi

export TF_VAR_hcloud_token=${HCLOUD_TOKEN}
export TF_VAR_hcloud_dns_token=${HCLOUD_DNS_TOKEN}
export TF_VAR_ssh_public_key=${SSH_PUBLIC_KEY}
export TF_VAR_storagebox_ssh_private_key=${STORAGEBOX_SSH_PRIVATE_KEY}

terraform "$@"
