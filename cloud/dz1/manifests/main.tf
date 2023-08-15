terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "ru-central1-b"
}

resource "yandex_vpc_network" "netology_vpc" {
  name        = "netology-vpc"
  description = "netology-vpc>"
  labels = {
    tf-label    = "tf-label-value"
    empty-label = ""
  }
}

resource "yandex_vpc_subnet" "public_net" {
  name           = "public"
  description    = "netology_public"
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-b"
  network_id     = "enptotp8nidqufce3jvd"
}

resource "yandex_vpc_subnet" "private_net" {
  name           = "private"
  description    = "netology_private"
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-b"
  network_id     = "enptotp8nidqufce3jvd"
  route_table_id = "${yandex_vpc_route_table.route-default.id}"
}

resource "yandex_compute_instance" "nat_instance" {
  description = "nat-instance"
  name        = "nat-instance-vm"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    cores  = 2 # vCPU
    memory = 4 # GB
  }

  boot_disk {
    initialize_params {
      image_id = "fd8qmbqk94q6rhb4m94t"
    }
  }

  network_interface {
    subnet_id = "e2le62mugtfitl235hdp"
    nat       = true
    ip_address     = "192.168.10.254" 

    # security_group_ids = [
    #   yandex_vpc_security_group.sg-internet.id,    # Allow any outgoing traffic to Internet.
    #   yandex_vpc_security_group.sg-nat-instance.id # Allow connections to and from the Data Proc cluster.
    # ]
  }

  metadata = {
    user-data = "${file("/Volumes/Sklad/GitHub/devops-netology/cloud/dz1/userdata")}"
    }
}

resource "yandex_compute_instance" "vm_in_pub" {
  description = "vm-in-pub"
  name        = "vm-in-pub"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"

  resources {
    cores  = 2 # vCPU
    memory = 4 # GB
  }

  boot_disk {
    initialize_params {
      image_id = "fd8ebb4u1u8mc6fheog1"
    }
  }

  network_interface {
    subnet_id = "e2le62mugtfitl235hdp"
    nat       = true

    # security_group_ids = [
    #   yandex_vpc_security_group.sg-internet.id,    # Allow any outgoing traffic to Internet.
    #   yandex_vpc_security_group.sg-nat-instance.id # Allow connections to and from the Data Proc cluster.
    # ]
  }

  metadata = {
    user-data = "${file("/Volumes/Sklad/GitHub/devops-netology/cloud/dz1/userdata")}"
    }
}

resource "yandex_compute_instance" "vm_in_private" {
  description = "vm-in-priv"
  name        = "vm-in-priv"
  platform_id = "standard-v3"
  zone        = "ru-central1-b"


  resources {
    cores  = 2 # vCPU
    memory = 4 # GB
  }

  boot_disk {
    initialize_params {
      image_id = "fd8ebb4u1u8mc6fheog1"
    }
  }

  network_interface {
    subnet_id = "e2lgb3gbjesbbu7lgbhc"
    nat       = false
    ip_address = "192.168.20.100" 

    # security_group_ids = [
    #   yandex_vpc_security_group.sg-internet.id,    # Allow any outgoing traffic to Internet.
    #   yandex_vpc_security_group.sg-nat-instance.id # Allow connections to and from the Data Proc cluster.
    # ]
  }

  metadata = {
    user-data = "${file("/Volumes/Sklad/GitHub/devops-netology/cloud/dz1/userdata")}"
    }
}

resource "yandex_vpc_route_table" "route-default" {
  name       = "to-Inet"
  network_id = "${yandex_vpc_network.netology_vpc.id}"
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}