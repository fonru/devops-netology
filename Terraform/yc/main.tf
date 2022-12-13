terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-a"
}


resource "yandex_compute_instance" "vm-1" {
  name = "ubuntu22"

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd89jk9j9vifp28uprop"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta/users.txt")}"
  }
}

resource "yandex_vpc_network" "network_1" {
  name = "net_1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "net_172.16.1.0/24"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_1.id
  v4_cidr_blocks = ["172.16.1.0/24"]
}