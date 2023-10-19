locals {
  folder_id = "b1gg8o8a9vtsgssmg3md"
  sa_name = "diplom-sa"
  backend_bucket = "diplom-tf"
  vpc = "diplom-vpc"
  zone_a = "ru-central1-a"
  zone_b = "ru-central1-b"
  subnet_zone_a = "172.16.100.0/24"
  subnet_zone_b = "172.16.200.0/24"

  #### K8S nodes Masters
  master_image = "fd8ebb4u1u8mc6fheog1"
  master_ram = 4
  master_cpu = 2
  master_disk_size = 21474836480
  master_A_zone = "ru-central1-a"
  master_B_zone = "ru-central1-b"
  master_C_zone = "ru-central1-b"
  master_A_name = "k8s-master-a"
  master_B_name = "k8s-master-b"
  master_C_name = "k8s-master-c"

  #### K8S nodes Workers
  worker_image = "fd8ebb4u1u8mc6fheog1"
  worker_ram = 4
  worker_cpu = 2
  worker_disk_size = 21474836480
  worker_A_zone = "ru-central1-a"
  worker_B_zone = "ru-central1-b"
  worker_A_name = "k8s-worker-a"
  worker_B_name = "k8s-worker-b"

  #### Disk ####
  master_A_disk_name = "disk-master-a"
  master_A_disk_size = 40
  master_B_disk_name = "disk-master-b"
  master_B_disk_size = 40
  master_C_disk_name = "disk-master-c"
  master_C_disk_size = 40
  worker_A_disk_name = "disk-worker-a"
  worker_A_disk_size = 40
  worker_B_disk_name = "disk-worker-b"
  worker_B_disk_size = 40

  #### External LB ####
  ext_lb_name = "ext-haproxy"
  ext_lb_zone = "ru-central1-a"
  ext_lb_disk = 8
  ext_lb_image = "fd8ebb4u1u8mc6fheog1"
}
