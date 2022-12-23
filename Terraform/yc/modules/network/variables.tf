variable "network_name" {
  type        = string
  description = "network_name"
  default = "network_1"
}

variable "subnet_name" {
  type        = string
  description = "subnet name"
  default = "net_172.16.1.0/24"
}

variable "zone" {
  type        = string
  description = "zone"
  default = "ru-central1-a" 
}

variable "subnet_cidr" {
  description = "cidr"
  default = [
    "172.16.1.0/24"
  ]
}
