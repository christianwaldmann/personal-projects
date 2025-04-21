
resource "hcloud_server" "projects-server" {
    name = "personal-projects"
    server_type = "cx22"
    image = data.hcloud_image.this.id
    location = "fsn1"
    ssh_keys = [
        hcloud_ssh_key.default.id
    ]
    user_data = data.cloudinit_config.this.rendered
    firewall_ids = [
        hcloud_firewall.basic.id
    ]
}
