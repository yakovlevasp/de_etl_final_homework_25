output "ydb_full_endpoint" {
  description = "YDB full endpoint for connection"
  value       = yandex_ydb_database_serverless.transactions_db.ydb_full_endpoint
  sensitive   = true
}

output "ydb_database_path" {
  description = "YDB database path"
  value       = yandex_ydb_database_serverless.transactions_db.database_path
  sensitive   = true
}