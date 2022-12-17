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
  token     = "xxxxxxxxxxxx"
  cloud_id  = "b1gsr0kdgo2k62r0co5o"
  folder_id = "b1gl9omrk477ufib716u"
}






