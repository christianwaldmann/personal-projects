locals {

}

packer {
  required_plugins {
    hcloud = {
      source  = "github.com/hetznercloud/hcloud"
      version = ">= 1.2.0"
    }
  }
}

variable "aws_access_key_id" {
  type = string
}

variable "aws_secret_access_key" {
  type = string
  sensitive = true
}

source "hcloud" "this" {
  image         = "ubuntu-24.04"
  location      = "fsn1"
  server_type   = "cx22"
  user_data     = ""
  ssh_username  = "root"
  snapshot_name = "personal-projects-base-{{isotime `2006-01-02`}}"
  snapshot_labels = {
    source = "packer"
    name = "personal-projects"
  }
}

build {
  sources = ["source.hcloud.this"]

  provisioner "shell" {
    execute_command = "sudo -S env {{ .Vars }} {{ .Path }}"
    inline = [
      "mkdir /app && chmod 0777 /app"
    ]
  }

  provisioner "file" {
    destination = "/app/"
    source = "../config/docker-compose.yaml"
  }

  provisioner "file" {
    destination = "/app/"
    source = "../config/.env"
  }

  provisioner "shell" {
    execute_command = "sudo -S env {{ .Vars }} {{ .Path }}"
    inline = [
      "mkdir /root/.aws",
      "echo '[default]' > /root/.aws/credentials",
      "echo 'aws_access_key_id=${var.aws_access_key_id}' >> /root/.aws/credentials",
      "echo 'aws_secret_access_key=${var.aws_secret_access_key}' >> /root/.aws/credentials",
      "chmod 600 /root/.aws/credentials"
    ]
  }

  provisioner "shell" {
    execute_command = "sudo -S env {{ .Vars }} {{ .Path }}"
    script = "install.sh"
  }
}
