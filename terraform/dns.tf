
resource "hcloud_zone" "this" {
  name              = "christianw.de"
  mode              = "primary"
  ttl               = 3600
  delete_protection = true
}

resource "hcloud_zone_rrset" "geometrierechner" {
  zone = resource.hcloud_zone.this.name
  type = "A"
  name = "geometrierechner"
  records = [
    { value = hcloud_server.this.ipv4_address, comment = "managed by terraform" }
  ]
}

resource "hcloud_zone_rrset" "bookmarks" {
  zone = resource.hcloud_zone.this.name
  type = "A"
  name = "bookmarks"
  records = [
    { value = hcloud_server.this.ipv4_address, comment = "managed by terraform" }
  ]
}

resource "hcloud_zone_rrset" "bookmarks-api" {
  zone = resource.hcloud_zone.this.name
  type = "A"
  name = "api.bookmarks"
  records = [
    { value = hcloud_server.this.ipv4_address, comment = "managed by terraform" }
  ]
}

resource "hcloud_zone_rrset" "homepage" {
  zone = resource.hcloud_zone.this.name
  type = "A"
  name = "@"
  records = [
    { value = hcloud_server.this.ipv4_address, comment = "managed by terraform" }
  ]
}

resource "hcloud_zone_rrset" "news" {
  zone = resource.hcloud_zone.this.name
  type = "A"
  name = "news"
  records = [
    { value = hcloud_server.this.ipv4_address, comment = "managed by terraform" }
  ]
}
