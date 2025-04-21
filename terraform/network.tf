
resource "hcloud_network" "this" {
    name     = "private-network"
    ip_range = "10.0.0.0/8"
}

resource "hcloud_network_subnet" "this" {
    network_id   = hcloud_network.this.id
    type         = "cloud"
    network_zone = "eu-central"
    ip_range     = "10.0.1.0/24"
}

resource "hcloud_server_network" "this" {
    server_id = hcloud_server.this.id
    network_id = hcloud_network.this.id
    ip = "10.0.1.2"
}
