terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {}
variable "tailscale_auth_key" {}
variable "do_ssh_key_id" {}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_droplet" "droplet" {
  image     = "ubuntu-24-04-x64"
  name      = "nyc1-terraform-caddy"
  region    = "atl1"
  size      = "s-1vcpu-1gb-35gb-intel"
  ssh_keys  = [var.do_ssh_key_id]
  user_data = templatefile("digitalocean.tftpl", { tailscale_auth_key = var.tailscale_auth_key })
}