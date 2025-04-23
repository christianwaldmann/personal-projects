locals {
    update_config_script = templatefile("${path.module}/cloud-init.d/update-config.sh", {

    })
    docker_compose_file = templatefile("${path.module}/../config/docker-compose.yaml", {

    })
    backup_script = templatefile("${path.module}/cloud-init.d/backup.sh", {

    })
    storagebox_ssh_private_key = base64encode(
        format("%s\n", replace(var.storagebox_ssh_private_key, "\\n", "\n"))
    )
}

data "cloudinit_config" "this" {
    gzip = true
    base64_encode = true

    // Basic cloud-config configuration file
    part {
        filename = "init.cfg"
        content_type = "text/cloud-config"
        content = templatefile("${path.module}/cloud-init.d/init.tpl", {
            update_config_script = local.update_config_script
            backup_script = local.backup_script
            storagebox_ssh_private_key = local.storagebox_ssh_private_key
        })
    }

    // Configuration
    part {
        filename = "init.sh"
        content_type = "text/x-shellscript"
        content = templatefile("${path.module}/cloud-init.d/init.sh", {
            docker_compose_file = local.docker_compose_file
        })
    }
}
