resource "yandex_compute_instance" "ext_lb" {
  description = "external_LB"
  name        = local.ext_lb_name
  platform_id = "standard-v3"
  zone        = local.ext_lb_zone
  hostname = local.ext_lb_name

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = local.ext_lb_image
      size = local.ext_lb_disk
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.subnet-a.id}"
    nat       = true

  }
  scheduling_policy {
    preemptible = true
  }
  metadata = {
    user-data = "${file("userdata")}"
    }
}