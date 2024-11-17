
resource "hetznerdns_record" "geometrierechner" {
    zone_id = data.hetznerdns_zone.this.id
    type    = "A"
    name    = "geometrierechner"
    value   = hcloud_server.projects-server.ipv4_address
}

resource "hetznerdns_record" "bookmarks" {
    zone_id = data.hetznerdns_zone.this.id
    type    = "A"
    name    = "bookmarks"
    value   = hcloud_server.projects-server.ipv4_address
}

resource "hetznerdns_record" "bookmarks-api" {
    zone_id = data.hetznerdns_zone.this.id
    type    = "A"
    name    = "api.bookmarks"
    value   = hcloud_server.projects-server.ipv4_address
}

resource "hetznerdns_record" "homepage" {
    zone_id = data.hetznerdns_zone.this.id
    type    = "A"
    name    = "@"
    value   = hcloud_server.projects-server.ipv4_address
}
