terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "terra-buck"
    region     = "ru-central1"
    key        = "main.tfstate"
    access_key = "YCAJEnmNEYXTRxumOLaoSSYPg"
    secret_key = "YCNNHUg5tUZYs3IU898KaPk5xUWtP0Ww_tJqkKrn"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  zone = "ru-central1-a"
  token     = "${var.yc_token}"
  cloud_id  = "${var.yc_cloud_id}"
  folder_id = "${var.yc_folder_id}"
}






