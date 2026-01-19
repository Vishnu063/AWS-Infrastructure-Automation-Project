This project automates AWS infrastructure provisioning using Terraform, featuring reusable modules for VPC, EC2, and S3 resources. Integrated with CI/CD pipelines for automated infrastructure testing and deployment.
## 🎯 Features
- **Infrastructure as Code**: Complete AWS environment defined in Terraform
- **Reusable Modules**: Modular design for VPC, EC2, and S3
- **CI/CD Integration**: Automated testing and deployment via GitHub Actions
- **Security Best Practices**: IAM roles, security groups, encrypted resources
- **High Availability**: Multi-AZ deployment with public/private subnets
## 🏗️ Architecture
┌─────────────────────────────────────────┐
│ AWS Infrastructure │
├─────────────────────────────────────────┤
│ VPC (10.0.0.0/16) │
│ ├── Public Subnets (10.0.1.0/24) │
│ │ └── EC2 Instances (Web Servers) │
│ ├── Private Subnets (10.0.2.0/24) │
│ └── S3 Bucket (Storage) │
└─────────────────────────────────────────┘

## 📁 Project Structure
terraform-aws-automation/
├── main.tf # Main configuration
├── variables.tf # Input variables
├── outputs.tf # Output values
├── versions.tf # Terraform versions
├── terraform.tfvars # Variable values (gitignored)
├── modules/ # Reusable modules
│ ├── vpc/ # VPC module
│ ├── ec2/ # EC2 module
│ └── s3/ # S3 module
└── .github/workflows/ # CI/CD pipelines

## 🚀 Quick Start

### Prerequisites
- AWS Account with IAM credentials
- Terraform v1.5.0+
- AWS CLI configured
- GitHub Account (for CI/CD)

### 1. Clone and Configure
```bash
git clone <repository-url>
cd terraform-aws-automation

# Copy example variables file
cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with your values
nano terraform.tfvars
terraform init
ẻxit

eof
