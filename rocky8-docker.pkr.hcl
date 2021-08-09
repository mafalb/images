# vim: set ft=yaml ts=2 expandtab:

packer {
  required_plugins {
    docker = {
      version = ">= 0.0.7"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "rocky" {
  image  = "quay.io/rockylinux/rockylinux:8"
  commit = true
    changes = [
      "ENTRYPOINT /bin/bash"
    ]
}

build {
  name = "rocky-systemd"
  sources = [
    "source.docker.rocky"
  ]
  provisioner "ansible" {
    playbook_file = "docker-systemd.yml"
  }
}
