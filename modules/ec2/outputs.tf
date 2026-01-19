output "instance_ids" {
  description = "IDs of the EC2 instances"
  value       = aws_instance.this[*].id
}

output "instance_public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = aws_eip.this[*].public_ip
}

output "instance_private_ips" {
  description = "Private IPs of the EC2 instances"
  value       = aws_instance.this[*].private_ip
}

output "instance_public_dns" {
  description = "Public DNS names of the EC2 instances"
  value       = aws_instance.this[*].public_dns
}
