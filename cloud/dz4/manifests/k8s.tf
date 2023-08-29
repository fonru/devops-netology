resource "yandex_kubernetes_cluster" "my-k8s" {
  network_id = yandex_vpc_network.netology_vpc.id
  name = "my-k8s"
  master {
    version = 1.27
    public_ip = true
    regional {
      region = "ru-central1"
      location {
        zone      = yandex_vpc_subnet.public_net.zone
        subnet_id = yandex_vpc_subnet.public_net.id
      }
      location {
        zone      = yandex_vpc_subnet.public_net2.zone
        subnet_id = yandex_vpc_subnet.public_net2.id
      }
      location {
        zone      = yandex_vpc_subnet.public_net3.zone
        subnet_id = yandex_vpc_subnet.public_net3.id
      }
    }
    # security_group_ids = [yandex_vpc_security_group.k8s-main-sg.id]
  }
  service_account_id      = "aje3eptg9tni0kv705do"
  node_service_account_id = "aje3eptg9tni0kv705do"
 
  kms_provider {
    key_id = yandex_kms_symmetric_key.main-key.id
  }
}

resource "yandex_kubernetes_node_group" "my-workers" {
  cluster_id = yandex_kubernetes_cluster.my-k8s.id
  name       = "my-workers"
  instance_template {
    name       = "worker-{instance.index}"
    platform_id = "standard-v2"
    nat = true
    container_runtime {
     type = "containerd"
    }
    metadata = {
        user-data = "${file("/Volumes/Sklad/GitHub/devops-netology/cloud/dz2/manifests/userdata")}"
    }
    }
  scale_policy {
    auto_scale {
      min     = 3
      max     = 6
      initial = 3
    }
  }
  allocation_policy {
    location {
      zone = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.public_net2.id
    }
  }
}