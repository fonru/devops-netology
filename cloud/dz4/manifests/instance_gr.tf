resource "yandex_compute_instance_group" "ig" {
  name                = "test-ig"
  folder_id           = "b1gl9omrk477ufib716u"
  service_account_id  = "aje8le1ecaf4449gertr"
  deletion_protection = "false"
#   depends_on          = [yandex_resourcemanager_folder_iam_member.editor]
  instance_template {
    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd8abro0qe094de08vrv"
      }
    }

    network_interface {
      network_id = "${yandex_vpc_network.netology_vpc.id}"
      subnet_ids = ["${yandex_vpc_subnet.public_net.id}"]
    }

    metadata = {
        user-data = "${file("/Volumes/Sklad/GitHub/devops-netology/cloud/dz2/manifests/userdata")}"
    }
  }
  health_check {
    tcp_options {
        port = 80
    }
  }
  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-b"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  
  }
}
