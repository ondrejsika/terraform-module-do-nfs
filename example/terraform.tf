variable "do_token" {}
variable "cloudflare_email" {}
variable "cloudflare_token" {}

provider "digitalocean" {
  token = var.do_token
}

provider "cloudflare" {
  version = "~> 1.0"
  email = var.cloudflare_email
  token = var.cloudflare_token
}

data "digitalocean_ssh_key" "ondrejsika" {
  name = "ondrejsika"
}

module "nfs" {
  source = "./.."
  tf_ssh_key = data.digitalocean_ssh_key.ondrejsika
}

resource "cloudflare_record" "nfs" {
  domain = "sikademo.com"
  name   = "nfs-module"
  value  = module.nfs.ipv4_address
  type   = "A"
  proxied = false
}
