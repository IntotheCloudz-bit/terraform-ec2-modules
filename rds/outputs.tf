output "identifier" {
  description = "RDS instance identifier"
  value       = aws_db_instance.this.identifier
}

output "address" {
  description = "Database hostname without the port"
  value       = aws_db_instance.this.address
}

output "port" {
  description = "Database connection port"
  value       = aws_db_instance.this.port
}

output "database_name" {
  description = "Initial database name"
  value       = aws_db_instance.this.db_name
}

output "master_secret_arn" {
  description = "ARN of the RDS-managed administrator secret"
  value       = aws_db_instance.this.master_user_secret[0].secret_arn
}