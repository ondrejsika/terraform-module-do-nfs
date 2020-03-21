variable "do_token" {}
variable "cloudflare_email" {}
variable "cloudflare_token" {}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  email = var.cloudflare_email
  token = var.cloudflare_token
}

data "digitalocean_droplet_snapshot" "nfs" {
  name  = "nfs"
  region = "fra1"
  most_recent = true
}


data "digitalocean_ssh_key" "ondrejsika" {
  name = "ondrejsika"
}


resource "digitalocean_droplet" "nfs" {
  image  = data.digitalocean_droplet_snapshot.nfs.id
  name   = "nfs"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.ondrejsika.id
  ]
}

resource "cloudflare_record" "nfs" {
  domain = "sikademo.com"
  name   = "nfs"
  value  = digitalocean_droplet.nfs.ipv4_address
  type   = "A"
  proxied = false
}
