output "repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.this.name
}

output "repository_arn" {
  description = "ARN used when defining IAM permissions"
  value       = aws_ecr_repository.this.arn
}

output "repository_url" {
  description = "Repository address used to tag, push, and pull images"
  value       = aws_ecr_repository.this.repository_url
}

output "registry_id" {
  description = "AWS account ID associated with the registry"
  value       = aws_ecr_repository.this.registry_id
}