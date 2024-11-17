#!/usr/bin/env bash
set -euo pipefail

apt-get update
apt-get install --yes \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    gnupg-agent \
    vim \
    tmux \
    git \
    unzip \
    jq

# aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -r aws awscliv2.zip

# docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt-key fingerprint 0EBFCD88

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get dist-upgrade --yes
apt-get install docker-ce docker-ce-cli containerd.io docker-compose --yes

systemctl enable docker
systemctl start docker

docker-compose -f /app/docker-compose.yaml pull --quiet
