resource "yandex_compute_instance" "inst" {
    count = var.vm_count
    name = "INST1_-${count.index}-${terraform.workspace}"

    resources {
      cores  = var.vm_core
      memory = var.vm_memory
    }

    boot_disk {
      initialize_params {
        image_id = var.vm_image_id
    }
    }
    network_interface {
      subnet_id = "yandex_vpc_subnet.${var.subnet_name}.id"
      nat       = var.nat_state
    }
    
    metadata = {
        user-data = "${file("./meta/users.txt")}"
    }

    lifecycle {
    create_before_destroy = true
  }
}
