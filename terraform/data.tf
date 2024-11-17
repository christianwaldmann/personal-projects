
data "hcloud_image" "this" {
    with_selector = "source=packer"
    most_recent = true
}

data "hetznerdns_zone" "this" {
    name = "christianw.de"
}
