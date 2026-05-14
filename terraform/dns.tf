
resource "hcloud_zone_record" "geometrierechner" {
    zone    = data.hcloud_zone.this.name
    type    = "A"
    name    = "geometrierechner"
    value   = hcloud_server.this.ipv4_address
    comment = "managed by terraform"
}

resource "hcloud_zone_record" "bookmarks" {
    zone    = data.hcloud_zone.this.name
    type    = "A"
    name    = "bookmarks"
    value   = hcloud_server.this.ipv4_address
    comment = "managed by terraform"
}

resource "hcloud_zone_record" "bookmarks-api" {
    zone    = data.hcloud_zone.this.name
    type    = "A"
    name    = "api.bookmarks"
    value   = hcloud_server.this.ipv4_address
    comment = "managed by terraform"
}

resource "hcloud_zone_record" "homepage" {
    zone    = data.hcloud_zone.this.name
    type    = "A"
    name    = "@"
    value   = hcloud_server.this.ipv4_address
    comment = "managed by terraform"
}

