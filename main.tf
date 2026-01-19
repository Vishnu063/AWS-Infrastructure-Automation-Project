# Main Terraform Configuration

# Provider Configuration
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(
      var.common_tags,
      {
        Project     = var.project_name
        Environment = var.environment
        ManagedBy   = "Terraform"
      }
    )
  }
}

# Random ID for unique resource names
resource "random_id" "suffix" {
  byte_length = 4
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = ["ap-south-1a", "ap-south-1b"]

  tags = merge(
    var.common_tags,
    {
      Module = "vpc"
    }
  )
}

# EC2 Module
module "ec2" {
  source = "./modules/ec2"

  project_name       = var.project_name
  environment        = var.environment
  instance_count     = var.instance_count
  instance_type      = var.instance_type
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [module.vpc.web_security_group_id]
  key_name           = var.key_name
  assign_public_ip   = true

  tags = merge(
    var.common_tags,
    {
      Module = "ec2"
    }
  )
}

# S3 Module
module "s3" {
  source = "./modules/s3"

  bucket_name       = "${var.project_name}-${var.environment}-${random_id.suffix.hex}"
  enable_versioning = var.enable_s3_versioning
  enable_encryption = var.enable_s3_encryption

  lifecycle_rules = [
    {
      id     = "log_lifecycle"
      status = "Enabled"
      transitions = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        }
      ]
      expiration = {
        days = 365
      }
    }
  ]

  tags = merge(
    var.common_tags,
    {
      Module = "s3"
    }
  )
}

# Create SSH Key Pair
resource "aws_key_pair" "terraform_key" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub") # Use your existing SSH public key

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-keypair"
    }
  )
}

# Output bucket name for reference
resource "aws_s3_bucket_object" "terraform_output" {
  bucket = module.s3.bucket_id
  key    = "terraform/output.json"
  content = jsonencode({
    vpc_id       = module.vpc.vpc_id
    instance_ips = module.ec2.instance_public_ips
    bucket_name  = module.s3.bucket_id
    deployed_at  = timestamp()
    environment  = var.environment
  })

  content_type = "application/json"
}
