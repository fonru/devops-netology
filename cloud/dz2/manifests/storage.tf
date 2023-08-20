# terraform {
#   required_providers {
#     yandex = {
#       source = "yandex-cloud/yandex"
#     }
#   }
#   required_version = ">= 0.13"
# }

# provider "yandex" {
#   zone = "ru-central1-b"
# }
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "aje3eptg9tni0kv705do"
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "pub-buket" {
  bucket = "mfonarev-netology"
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  acl = "public-read"
}

resource "yandex_storage_object" "pub-upload" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "mfonarev-netology"
  key = "pic1"
  source = "1.jpg"
}
