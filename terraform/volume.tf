
resource "hcloud_volume" "this" {
    name = "persistent-storage"
    size = 10
    format = "ext4"
    delete_protection = true # this disables the "delete" button in the Hetzner UI

    # Attach volume to server
    server_id = hcloud_server.projects-server.id
    automount = true

    # prevent terraform from deleting this volume
    lifecycle {
        prevent_destroy = true
    }
}
