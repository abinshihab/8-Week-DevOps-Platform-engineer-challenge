output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}
output "security_group_ids" {
  description = "List of security group IDs created by VPC module"
  value       = [aws_security_group.vpc_default_sg.id]
}
