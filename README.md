# AWS Infrastructure Automation

Terraform modules for VPC, EC2, and S3, with a GitHub Actions workflow for infrastructure operations.

[Reviewer walkthrough](INTERVIEW.md) · [Workflow](.github/workflows/terraform-ci.yml)

## Source layout

| Path | Purpose |
| --- | --- |
| [main.tf](main.tf) | Root module composition |
| [modules/vpc](modules/vpc) | Network resources |
| [modules/ec2](modules/ec2) | Compute resources and initialization |
| [modules/s3](modules/s3) | Object storage resources |
| [backend.tf](backend.tf) | State backend configuration |
| [terraform.tfvars.example](terraform.tfvars.example) | Example input values |

## Review before execution

Clone the repository and inspect the backend, variables, and modules first:

```bash
git clone https://github.com/Vishnu063/AWS-Infrastructure-Automation-Project.git
cd AWS-Infrastructure-Automation-Project
terraform fmt -check -recursive
terraform init -backend=false
terraform validate
```

These commands require Terraform and provider downloads. They are suggested local checks, not newly verified results. Backend-free initialization does not validate your remote state access or prove that an apply will succeed.

The existing workflow includes an automatic apply on pushes to main. Review its credentials, backend, plan handling, and approval policy before enabling it in an account. Do not push infrastructure changes merely to try this demo. No cloud resources were provisioned during this documentation review.

## Interview discussion

Explain module boundaries, variable validation, state locking, permissions, and the plan you would review before applying. Demonstrate a real validation or plan result using an authorized disposable environment. Resource definitions alone do not establish high availability, production security, or free-tier eligibility.
