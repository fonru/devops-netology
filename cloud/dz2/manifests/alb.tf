resource "yandex_alb_target_group" "my-alb" {
  name      = "my-alb"
  target {
    subnet_id = "${yandex_vpc_subnet.public_net.id}"
    ip_address   = "192.168.10.13"
  }

  target {
    subnet_id = "${yandex_vpc_subnet.public_net.id}"
    ip_address   = "192.168.10.21"
  }

  target {
    subnet_id = "${yandex_vpc_subnet.public_net.id}"
    ip_address   = "192.168.10.22"
  }
}

resource "yandex_alb_backend_group" "my-back-group" {
  name      = "my-back-group"

  http_backend {
    name = "my-back"
    weight = 1
    port = 80
    target_group_ids = ["${yandex_alb_target_group.my-alb.id}"]
    load_balancing_config {
      panic_threshold = 50
    }    
    healthcheck {
      timeout = "1s"
      interval = "1s"
      http_healthcheck {
        path  = "/"
      }
    }
    http2 = "false"
  }
}

resource "yandex_alb_http_router" "alb-router" {
  name      = "my-http-router"
}

resource "yandex_alb_virtual_host" "alb-vh" {
  name      = "alb-vh"
  http_router_id = yandex_alb_http_router.alb-router.id
  route {
    name = "main-route"
    http_route {
      http_match {
        path {
            exact = "/picture"
        }
      }
      http_route_action {
        backend_group_id = yandex_alb_backend_group.my-back-group.id
        timeout = "3s"
        prefix_rewrite = "/"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "my-alb" {
  name        = "my-alb"

  network_id  = yandex_vpc_network.netology_vpc.id
  
  allocation_policy {
    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.public_net.id 
    }
  }
  
  listener {
    name = "my-alb-lister"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }    
    http {
      handler {
        http_router_id = yandex_alb_http_router.alb-router.id
      }
    }
  }
  
#   log_options {
#     discard_rule {
#       http_code_intervals = ["2XX"]
#       discard_percent = 75
#     }
#   }
}