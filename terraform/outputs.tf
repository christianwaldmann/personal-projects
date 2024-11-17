
output "server_ip" {
    value = hcloud_server.projects-server.ipv4_address
}

output "status" {
    value = hcloud_server.projects-server.status
}
