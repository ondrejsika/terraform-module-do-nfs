variable "tf_ssh_key" {}
variable "name" {
  default = "nfs"
}
variable "region" {
  default = "fra1"
}
variable "size" {
  default = "s-1vcpu-1gb"
}

resource "digitalocean_droplet" "nfs" {
  image  = "debian-10-x64"
  name   = var.name
  region = var.region
  size   = var.size
  ssh_keys = [
    var.tf_ssh_key.id
  ]
  connection {
    type = "ssh"
    user = "root"
    host = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get update",
      "apt-get install -y nfs-kernel-server",
      "mkdir /nfs",
      "echo '/nfs *(rw,no_root_squash)' > /etc/exports",
      "systemctl restart nfs-kernel-server"
    ]
  }
}

output "ipv4_address" {
  value = digitalocean_droplet.nfs.ipv4_address
}
