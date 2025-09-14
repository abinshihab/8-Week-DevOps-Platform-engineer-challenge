

output "bastion_sg_id" {
  description = "Security group ID of the bastion host"
  value       = aws_security_group.bastion_sg.id
}

output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}
output "bastion_private_ip" {
  description = "Private IP of the bastion host"
  value       = aws_instance.bastion.private_ip
}