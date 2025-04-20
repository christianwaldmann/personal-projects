#!/usr/bin/env bash

HERE=$(dirname "$0")
cd "${HERE}/../packer"

if [[ -n $(git status -s) ]]; then
    echo >&2 "Error: Working directory is not clean. Please commit first."
    exit 1
fi

if [ -z "${AWS_ACCESS_KEY_ID:-}" ]; then
  echo >&2 "Error: AWS_ACCESS_KEY_ID is not set. Please export it before running this script."
  exit 1
fi

if [ -z "${AWS_SECRET_ACCESS_KEY:-}" ]; then
  echo >&2 "Error: AWS_SECRET_ACCESS_KEY is not set. Please export it before running this script."
  exit 1
fi

packer init -var "aws_access_key_id=${AWS_ACCESS_KEY_ID}" -var "aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}" .
packer validate -var "aws_access_key_id=${AWS_ACCESS_KEY_ID}" -var "aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}" .

if [[ "${1:-}" = "validate" ]]; then
    exit 0
fi

packer build -var "aws_access_key_id=${AWS_ACCESS_KEY_ID}" -var "aws_secret_access_key=${AWS_SECRET_ACCESS_KEY}" "$@" .
