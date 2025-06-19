variable "yc_token" {
  description = "Yandex.Cloud OAuth token"
  type        = string
  sensitive   = true
}

variable "yandex_cloud_id" {
  description = "Cloud ID"
  type        = string
  sensitive   = true
}

variable "yandex_folder_id" {
  description = "Folder ID"
  type        = string
  sensitive   = true
}

variable "zone" {
  type        = string
  description = "Yandex Cloud zone"
  default     = "ru-central1-a"
}

variable "bucket_name" {
  description = "Object Storage bucket name"
  type        = string
  default     = "task1-ydb-transactions-export"
}