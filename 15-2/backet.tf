resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "ajerbcd6fv5okv5pdkq5"
  description        = "static access key for object storage"
}

resource "yandex_storage_bucket" "netology-mosin" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "netology-mosin"
  anonymous_access_flags {
    read = true
    list = false
  }
}

resource "yandex_storage_object" "object" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = yandex_storage_bucket.netology-mosin.id
  key        = "tree.png"
  source     = "tree.png"
  acl        = "public-read"
}
