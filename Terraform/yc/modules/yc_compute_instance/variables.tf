variable "inst_name" {
  type = string
  default = "inst_1"
}

variable "vm_count" {
  type        = number
  description = "vm_count"
  default = 1
}

variable "vm_core" {
  type        = number
  description = "number of CPU"
  default = 2
}

variable "vm_memory" {
  type        = number
  description = "number of memory"
  default = 2
}

variable "vm_image_id" {
  type        = string
  description = "number of memory"
  default = "fd89jk9j9vifp28uprop"
}

variable "subnet_name" {
  type        = string
  description = "subnet name"
  default = "subnet-1"
}

variable "nat_state" {
  type = bool
  default = true
}