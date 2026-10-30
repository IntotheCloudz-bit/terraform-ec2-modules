output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = aws_lb.this.arn
}

output "alb_dns_name" {
  description = "AWS-generated DNS name of the ALB"
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  description = "Canonical hosted zone ID for a future Route 53 alias"
  value       = aws_lb.this.zone_id
}

output "target_group_arn" {
  description = "Target group ARN used by the ECS service"
  value       = aws_lb_target_group.this.arn
}

output "http_listener_arn" {
  description = "ARN of the HTTP listener"
  value       = aws_lb_listener.http.arn
}

output "application_url" {
  description = "HTTP URL for initial lab testing"
  value       = "http://${aws_lb.this.dns_name}"
}
