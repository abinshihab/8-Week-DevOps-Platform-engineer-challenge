output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "igw_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.this.id
}

output "public_subnet_ids" {
  description = "IDs of Public Subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of Private Subnets"
  value       = aws_subnet.private[*].id
}

output "nat_gateway_ids" {
  description = "IDs of NAT Gateways"
  value       = aws_nat_gateway.nat[*].id
}

output "public_route_table_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Private Route Table IDs"
  value       = aws_route_table.private[*].id
}
output "vpc_cidr" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.this.cidr_block
}
output "private_subnets" {
  value = aws_subnet.private[*].id
}
