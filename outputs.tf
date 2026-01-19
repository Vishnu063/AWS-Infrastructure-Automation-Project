# Output values

output "vpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = module.vpc.private_subnet_ids
}

output "web_security_group_id" {
  description = "ID of the web security group"
  value       = module.vpc.web_security_group_id
}

output "ec2_instance_ids" {
  description = "IDs of the EC2 instances"
  value       = module.ec2.instance_ids
}

output "ec2_public_ips" {
  description = "Public IPs of the EC2 instances"
  value       = module.ec2.instance_public_ips
  sensitive   = true
}

output "ec2_public_dns" {
  description = "Public DNS names of the EC2 instances"
  value       = module.ec2.instance_public_dns
}

output "website_urls" {
  description = "Website URLs for the EC2 instances"
  value       = [for ip in module.ec2.instance_public_ips : "http://${ip}"]
}

output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = module.s3.bucket_id
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = module.s3.bucket_arn
}

output "ssh_key_name" {
  description = "Name of the SSH key pair"
  value       = aws_key_pair.terraform_key.key_name
}

output "deployment_summary" {
  description = "Summary of the deployment"
  value       = <<EOT
╔══════════════════════════════════════════════════════════╗
║              AWS Infrastructure Deployment               ║
╠══════════════════════════════════════════════════════════╣
║ Project:      ${var.project_name}                        ║
║ Environment:  ${var.environment}                         ║
║ Region:       ${var.aws_region}                          ║
╠══════════════════════════════════════════════════════════╣
║ VPC ID:       ${module.vpc.vpc_id}                       ║
║ EC2 Instances: ${length(module.ec2.instance_ids)} created║
║ S3 Bucket:    ${module.s3.bucket_id}                     ║
║                                                          ║
║ Websites:                                                ║
%{for url in [for ip in module.ec2.instance_public_ips : "http://${ip}"]}
║   • ${url}                                               ║
%{endfor}
╚══════════════════════════════════════════════════════════╝
EOT
}
