resource "yandex_vpc_network" "network_1" {
  name = var.network_name
}

resource "yandex_vpc_subnet" "subnet_default" {
  name           = var.subnet_name
  zone           = var.zone
  network_id     = "yandex_vpc_network.${var.network_name}.id"
  v4_cidr_blocks = var.subnet_cidr
}