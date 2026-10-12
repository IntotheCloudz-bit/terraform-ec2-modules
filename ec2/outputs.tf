output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.default.id
}

output "instance_public_ip" {
  description = "Public IPv4 address of the EC2 instance, if assigned"
  value       = aws_instance.default.public_ip
}