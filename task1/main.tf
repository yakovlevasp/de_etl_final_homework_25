resource "yandex_ydb_database_serverless" "transactions_db" {
  name        = "transactions-db"
  location_id = "ru-central1"
}

resource "yandex_iam_service_account" "dt_sa" {
  name        = "dt-transfer-sa"
  description = "Service account for Data Transfer"
}

resource "yandex_resourcemanager_folder_iam_binding" "ydb_viewer" {
  folder_id = var.yandex_folder_id
  role      = "ydb.viewer"
  members   = ["serviceAccount:${yandex_iam_service_account.dt_sa.id}"]
}

resource "yandex_resourcemanager_folder_iam_binding" "storage_editor" {
  folder_id = var.yandex_folder_id
  role      = "storage.editor"
  members   = ["serviceAccount:${yandex_iam_service_account.dt_sa.id}"]
}

resource "yandex_iam_service_account_static_access_key" "sa_key" {
  service_account_id = yandex_iam_service_account.dt_sa.id
}

resource "yandex_storage_bucket" "transactions_bucket" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.sa_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_key.secret_key
}

resource "yandex_vpc_network" "network" {
  name = "dt-network"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "dt-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_datatransfer_endpoint" "ydb_source" {
  name = "ydb-source-endpoint"
  settings {
    ydb_source {
      database           = yandex_ydb_database_serverless.transactions_db.database_path
      service_account_id = yandex_iam_service_account.dt_sa.id
      paths              = ["transactions"]
      subnet_id          = yandex_vpc_subnet.subnet.id
    }
  }
}