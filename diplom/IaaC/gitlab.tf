### Gitlab VM ###
resource "yandex_compute_instance" "gitlab" {
  description = "gitlab"
  name        = local.gitlab_name
  platform_id = "standard-v3"
  zone        = local.gitlab_zone
  hostname = local.gitlab_name
  allow_stopping_for_update = true

  resources {
    cores  = local.gitlab_cpu
    memory = local.gitlab_ram
  }

  boot_disk {
    initialize_params {
      image_id = local.gitlab_image
      size = local.gitlab_disk_size
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