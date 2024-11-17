
resource "hcloud_firewall" "basic" {
    name   = "basic"

    rule {
        description = "allow ssh"
        direction       = "in"
        port            = "22"
        protocol        = "tcp"
        source_ips = [
            "0.0.0.0/0",
            "::/0",
        ]
    }

    rule {
        description = "allow HTTP"
        direction = "in"
        port = "80"
        protocol = "tcp"
        source_ips = [
            "0.0.0.0/0",
            "::/0",
        ]
    }

    rule {
        description = "allow HTTPS"
        direction = "in"
        port = "443"
        protocol = "tcp"
        source_ips = [
            "0.0.0.0/0",
            "::/0",
        ]
    }
}
