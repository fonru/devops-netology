variable "yc_token" {
  type        = string
  description = "Yandex Cloud API key"
  default = "yc iam create-token"
}

variable "yc_cloud_id" {
  type        = string
  description = "Yandex Cloud id"
  default = "yc config get cloud-id"
}

variable "yc_folder_id" {
  type        = string
  description = "Yandex Cloud folder id"
  default = "yc config get folder-id"
}

variable "yc_zone" {
  type        = string
  description = "Yandex Cloud compute default zone"
  default     = "ru-central1-a"
}

locals {
  hosts = {
    stage = 1
    prod = 2
  }

  vms_num =  {
    "stage" = toset( ["1"])
    "prod" =  toset( ["1", "2"])
}
}