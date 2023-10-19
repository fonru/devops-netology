terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "diplom-tf"
    region     = "ru-central1"
    key        = "tfstate/tfstate.tf"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  # zone = local.zone[terraform.workspace]
  folder_id = local.folder_id
}
resource "yandex_iam_service_account" "sa" {
  name = local.sa_name
}

// Assigning roles to the service account
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = local.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Creating a static access key
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// Creating a bucket using the key
resource "yandex_storage_bucket" "test" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = local.backend_bucket
}

