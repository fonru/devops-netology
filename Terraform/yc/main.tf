# resource "yandex_compute_instance" "instance_1" {

#   count = local.hosts[terraform.workspace]
  
#   name = "INST1_ubuntu-${count.index}-${terraform.workspace}"

#   resources {
#     cores  = 2
#     memory = 2
#   }

#   boot_disk {
#     initialize_params {
#       image_id = "fd89jk9j9vifp28uprop"
#     }
#   }

#   network_interface {
#     subnet_id = yandex_vpc_subnet.subnet-1.id
#     nat       = true
#   }

#   metadata = {
#     user-data = "${file("./meta/users.txt")}"
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "yandex_compute_instance" "instance_2" {
  
#   for_each = local.vms_num[terraform.workspace]
#     name = "inst2_ubuntu-${each.key}-${terraform.workspace}"

#     resources {
#       cores = 2
#       memory = 2
#     }

#     boot_disk {
#       initialize_params {
#         image_id = "fd89jk9j9vifp28uprop"
#       }
#     }

#     network_interface {
#       subnet_id = yandex_vpc_subnet.subnet-1.id
#       nat       = true
#     }

#     metadata = {
#       user-data = "${file("./meta/users.txt")}"
#     }
# }


### NETWORK ###

# resource "yandex_vpc_network" "network_1" {
#   name = "net_1"
# }

# resource "yandex_vpc_subnet" "subnet-1" {
#   name           = "net_172.16.1.0/24"
#   zone           = "ru-central1-a"
#   network_id     = yandex_vpc_network.network_1.id
#   v4_cidr_blocks = ["172.16.1.0/24"]
# }

###Compute instances###


### NETWORK ###
module "network" {
  source = "./modules/network"
}

### Compute Instances ###
module "yc_compute_instance" {
  source = "./modules/yc_compute_instance"
}