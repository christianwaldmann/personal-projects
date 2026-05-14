
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }

  backend "s3" {
    bucket       = "hetzner-terraform-state"
    key          = "personal-projects.tfstate"
    region       = "eu-central-1"
    use_lockfile = true
  }
}

provider "hcloud" {
  token = var.hcloud_token
}

