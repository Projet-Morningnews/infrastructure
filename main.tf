terraform {
  required_providers {
    ovh = {
      source = "ovh/ovh"
    }
  }
    backend "remote" {
    organization = "projet-morningnews"

    workspaces {
      name = "infrastructure"
}

provider "ovh" {
  endpoint           = "ovh-eu"
  application_key    = "var.ovh_application_key"
  application_secret = "var.ovh_application_secret"
  consumer_key       = "var.ovh_consumer_key"
}

resource "ovh_dedicated_server_install_task" "reinstall_os" {
  service_name = "var.server_name"
  template_name = "debian12_64"
  hostname      = "var.hostname"
  ssh_key_name  = "var.ssh_key_name"

  install_raid {
    mode = "soft"
    disks = ["sda"]
  }
}
