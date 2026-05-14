
data "hcloud_image" "this" {
    with_selector = "source=packer,name=personal-projects"
    most_recent = true
}

data "hcloud_zone" "this" {
    name = "christianw.de"
}

