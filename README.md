# personal-projects

Infrastructure and configuration to host my personal projects on Hetzner Cloud

## Architecture

![Architecture diagram](images/architecture.svg)

## Features

- Secrets and Terraform state are stored in AWS (managed in [personal-aws](https://github.com/christianwaldmann/personal-aws))
- CrowdSec helps to protect against malicious login attempts
- Automations:
    - For each PR `terraform plan` is run and the result is added as comment to the PR
    - Pushes to `master` trigger `terraform apply`
    - Packer builds a new base image with updated packages each month
    - Dependabot creates PRs for dependency updates; non-major updates are merged automatically
    - Traefik handles TLS certificates

## Backups

Backups use the Hetzner Storagebox. There are some manual steps required to set it up:
1. Create SSH key to access Storagebox: `ssh-keygen -f ~/.ssh/storagebox -N ""`
2. Upload public SSH key to Storagebox: `cat ~/.ssh/storagebox.pub | ssh -p 23 <username>@<username>.your-storagebox.de install-ssh-key`
3. Add private SSH key to Github secrets
4. Create directory in Storagebox: `mkdir -p /home/backups/personal-projects`

## TODO

- bootstrap
- manage dns zone completely via terraform
- tag all resources with the source repo
- check if "env_file" can be removed from docker compose file
- replace domain in docker-compose with envsubst
- sandbox env
- traefik monitoring with crowdsec
- use ssm for SSH_PUBLIC_KEY instead of passing
