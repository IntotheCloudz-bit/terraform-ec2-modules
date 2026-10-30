
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.main.cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the two public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of private subnets with routing ready"
  value       = aws_subnet.private[*].id

  # Make sure private-subnet outbound routing is configured
  # before dependent resources use these subnet IDs.
  depends_on = [
    aws_route.private_nat,
    aws_route_table_association.private,
    aws_route.public_internet,
    aws_route_table_association.public
  ]
}
output "availability_zones" {
  description = "Availability Zones used by the VPC subnets"
  value       = local.availability_zones
}

output "nat_gateway_ids" {
  description = "IDs of the two NAT Gateways"
  value       = aws_nat_gateway.main[*].id
}