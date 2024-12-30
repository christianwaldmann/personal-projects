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

# crowdsec
curl -fsSL https://packagecloud.io/crowdsec/crowdsec/gpgkey | gpg --dearmor > /etc/apt/keyrings/crowdsec.gpg
echo "deb [signed-by=/etc/apt/keyrings/crowdsec.gpg] https://packagecloud.io/crowdsec/crowdsec/any/ any main" \
    > "/etc/apt/sources.list.d/crowdsec.list"

apt-get update
apt-get install --yes crowdsec crowdsec-firewall-bouncer-iptables

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
apt-get install --yes docker-ce docker-ce-cli containerd.io docker-compose

systemctl enable docker
systemctl start docker

docker-compose -f /app/docker-compose.yaml pull --quiet
