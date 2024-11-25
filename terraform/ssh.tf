
resource "hcloud_ssh_key" "default" {
    name       = "Personal Key"
    public_key = var.ssh_public_key
}
