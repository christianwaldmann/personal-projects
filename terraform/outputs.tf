
output "server_ip" {
    value = hcloud_server.this.ipv4_address
}

output "status" {
    value = hcloud_server.this.status
}
