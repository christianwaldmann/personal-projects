#!/usr/bin/env bash
set -euo pipefail

HERE=$(dirname "$0")
cd "${HERE}/../terraform"

export TF_VAR_hcloud_token=abc
export TF_VAR_hcloud_dns_token=def
export TF_VAR_ssh_public_key=xyz

echo "hello from script"
