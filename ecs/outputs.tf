output "cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.this.name
}

output "service_name" {
  description = "Name of the ECS service"
  value       = aws_ecs_service.this.name
}

output "task_definition_arn" {
  description = "ARN of the task definition revision"
  value       = aws_ecs_task_definition.this.arn
}

output "task_role_name" {
  description = "Application role name for attaching workload permissions"
  value       = aws_iam_role.task.name
}

output "task_role_arn" {
  description = "ARN of the application task role"
  value       = aws_iam_role.task.arn
}

output "execution_role_name" {
  description = "Execution role name for additional startup permissions"
  value       = aws_iam_role.execution.name
}

output "log_group_name" {
  description = "CloudWatch log group containing application logs"
  value       = aws_cloudwatch_log_group.this.name
}