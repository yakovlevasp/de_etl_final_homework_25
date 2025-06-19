terraform {
  required_version = ">= 1.6"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.142.0"
    }
    null = {
      source  = "hashicorp/null"
    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  zone      = var.zone
}