
resource "hcloud_zone_rrset" "geometrierechner" {
    zone    = data.hcloud_zone.this.name
    type    = "A"
    name    = "geometrierechner"
    records = [
      { value   = hcloud_server.this.ipv4_address, comment = "managed by terraform" }
    ]
}

resource "hcloud_zone_rrset" "bookmarks" {
    zone    = data.hcloud_zone.this.name
    type    = "A"
    name    = "bookmarks"
    records = [
      { value   = hcloud_server.this.ipv4_address, comment = "managed by terraform" }
    ]
}

resource "hcloud_zone_rrset" "bookmarks-api" {
    zone    = data.hcloud_zone.this.name
    type    = "A"
    name    = "api.bookmarks"
    records = [
      { value   = hcloud_server.this.ipv4_address, comment = "managed by terraform" }
    ]
}

resource "hcloud_zone_rrset" "homepage" {
    zone    = data.hcloud_zone.this.name
    type    = "A"
    name    = "@"
    records = [
      { value   = hcloud_server.this.ipv4_address, comment = "managed by terraform" }
    ]
}

