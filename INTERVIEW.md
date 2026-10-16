# AWS infrastructure with Terraform: reviewer guide

Terraform configuration organized into VPC, EC2, and S3 modules, with an existing GitHub Actions workflow.

## Start the review

Trace module inputs and outputs, state/backend configuration, and the difference between validation, plan, and apply.

| Source | Review focus |\n| --- | --- |\n| [backend.tf](backend.tf) | Implementation, assumptions, and operational boundaries |\n| [main.tf](main.tf) | Implementation, assumptions, and operational boundaries |\n| [.github/workflows/terraform-ci.yml](.github/workflows/terraform-ci.yml) | Triggers, credentials, failure handling, and deploy conditions |\n| [.gitignore](.gitignore) | Implementation, assumptions, and operational boundaries |\n| [modules/ec2/main.tf](modules/ec2/main.tf) | Implementation, assumptions, and operational boundaries |\n| [modules/ec2/outputs.tf](modules/ec2/outputs.tf) | Implementation, assumptions, and operational boundaries |

## A useful interview walkthrough

1. State the problem and the specific part you implemented or changed.
2. Open the source above and follow one request, release, or failure from start to finish.
3. Show a reproducible result, including an actual failure and the observation that confirms recovery.
4. Explain one tradeoff and one limitation. Distinguish a local test from a live deployment.

## Evidence and limits

This guide is based on the default-branch source inspected on 16 October 2026. It is a source review, not a fresh deployment or a certification of every feature. Existing CI runs and tests should be checked at the commit being demonstrated. Do not present screenshots, inherited code, planned features, or old README statements as proof of a current deployment.
