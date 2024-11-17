
resource "hcloud_ssh_key" "default" {
    name       = "Personal Key"
    public_key = file("~/.ssh/id_rsa.pub")
}
