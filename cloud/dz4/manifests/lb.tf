resource "yandex_lb_target_group" "target-gr" {
  name      = "my-target-group"
#   region_id = "ru-central1"

  target {
    subnet_id = "${yandex_vpc_subnet.public_net.id}"
    address   = "192.168.10.13"
  }

  target {
    subnet_id = "${yandex_vpc_subnet.public_net.id}"
    address   = "192.168.10.21"
  }

  target {
    subnet_id = "${yandex_vpc_subnet.public_net.id}"
    address   = "192.168.10.22"
  }
}

resource "yandex_lb_network_load_balancer" "lb" {
  name = "my-network-load-balancer"

  listener {
    name = "my-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = "${yandex_lb_target_group.target-gr.id}"

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}