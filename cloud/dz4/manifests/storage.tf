resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "aje3eptg9tni0kv705do"
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "pub-buket" {
  bucket = "mfonarev-netology"
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  acl = "public-read"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.main-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# resource "yandex_storage_object" "pub-upload" {
#   access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
#   secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
#   bucket     = "mfonarev-netology"
#   key = "pic1"
#   source = "1.jpg"
# }
resource "yandex_storage_object" "site" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "mfonarev-netology"
  key = "index.html"
  source = "index.html"
}