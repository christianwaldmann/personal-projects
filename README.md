# personal-projects

Infrastructure and configuration to host my personal projects on Hetzner Cloud

## Architecture

- Single Hetzner Server
- Traefik as reverse proxy
- Services run as Docker containers

## Features

- Secrets and Terraform state are stored in AWS (managed in [personal-aws](https://github.com/christianwaldmann/personal-aws))
- CrowdSec helps to protect against malicious login attempts
- Automations:
    - For each PR `terraform plan` is run and the result is added as comment to the PR
    - Pushes to `master` trigger `terraform apply`
    - Packer builds a new base image with updated packages each month
    - Dependabot creates PRs for dependency updates; non-major updates are merged automatically
    - Traefik handles TLS certificates

## TODO

- bootstrap
- backups: litestream to s3 bucket? or hetzner storagebox with borg backup?
- manage dns zone completely via terraform
- tag all resources with the source repo
- check if "env_file" can be removed from docker compose file
- replace domain in docker-compose with envsubst
- sandbox env
- traefik monitoring with crowdsec
