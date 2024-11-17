
terraform {
    required_providers {
        hcloud = {
            source = "hetznercloud/hcloud"
            version = "~> 1.45"
        }
        hetznerdns = {
            source  = "timohirt/hetznerdns"
            version = "2.2.0"
        }
    }

    backend "s3" {
        bucket = "hetzner-terraform-state"
        key = "personal-projects.tfstate"
        region = "eu-central-1"
        dynamodb_table = "terraform_state"
    }
}

provider "hcloud" {
    token = var.hcloud_token
}

provider "hetznerdns" {
    apitoken = var.hcloud_dns_token
}
