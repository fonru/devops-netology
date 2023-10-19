resource "yandex_vpc_network" "diplom-vpc" {
  name = local.vpc
}

resource "yandex_vpc_subnet" "subnet-a" {
  name = "subnet-a"
  v4_cidr_blocks = [local.subnet_zone_a]
  zone           = local.zone_a
  network_id     = "${yandex_vpc_network.diplom-vpc.id}"
}

resource "yandex_vpc_subnet" "subnet-b" {
  name = "subnet-b"
  v4_cidr_blocks = [local.subnet_zone_b]
  zone           = local.zone_b
  network_id     = "${yandex_vpc_network.diplom-vpc.id}"
}