
# Terraform AWS Infrastructure Automation

This repository contains GitHub Actions workflows to manage AWS infrastructure using Terraform. The workflows handle the initialization, planning, application, and destruction of Terraform configurations.

## Prerequisites

1. **GitHub Repository**: Ensure you have a GitHub repository set up.
2. **AWS IAM Role**: Create an IAM role in AWS that trusts the GitHub OIDC provider and has the necessary permissions to manage your AWS infrastructure.
3. **OIDC Configuration**: Ensure that your GitHub repository is configured to use OIDC for authentication with AWS.
4. **Terraform Configuration**: Place your Terraform configuration files in the root directory of the repository.

## Workflows

### 1. Terraform Apply Workflow

This workflow triggers on pull requests to the `Sami-PR-1` branch and can also be manually triggered using `workflow_dispatch`. It performs the following steps:

1. **Git Checkout**: Checks out the repository code.
2. **Configure AWS Credentials**: Assumes the IAM role using OIDC and configures AWS credentials.
3. **Setup Terraform**: Installs Terraform.
4. **Terraform Format**: Checks Terraform formatting.
5. **Terraform Init**: Initializes Terraform with the backend configuration.
6. **Terraform Validate**: Validates the Terraform configuration.
7. **Terraform Plan**: Generates and shows the Terraform plan for pull requests.
8. **Post Plan Status**: Posts the status of the Terraform plan to the pull request.
9. **Terraform Apply**: Applies the Terraform configuration if the push is to the `main` branch.

### 2. Terraform Destroy Workflow

This workflow triggers on pushes to the `main` branch. It performs the following steps:

1. **Git Checkout**: Checks out the repository code.
2. **Configure AWS Credentials**: Assumes the IAM role using OIDC and configures AWS credentials.
3. **Setup Terraform**: Installs Terraform.
4. **Terraform Init**: Initializes Terraform with the backend configuration.
5. **Terraform Destroy**: Destroys the Terraform-managed infrastructure.

## Setting Up the Workflows

1. **Create OIDC Provider in AWS**:
   - Go to the IAM console in AWS.
   - Navigate to "Identity providers" and create a new OIDC provider.
   - Use `https://token.actions.githubusercontent.com` as the provider URL.
   - Add the appropriate client IDs (`sts.amazonaws.com`).

2. **Create IAM Role**:
   - Create an IAM role with a trust relationship for the OIDC provider.
   - Attach policies to this role to grant permissions for managing your AWS infrastructure.

3. **Store Secrets in GitHub**:
   - Add the following secrets to your GitHub repository:
     - `AWS_REGION`: The AWS region where your resources are managed.
     - `AWS_ROLE`: The ARN of the IAM role to assume.
     - `AWS_BUCKET_NAME`: The name of the S3 bucket for Terraform state.
     - `AWS_BUCKET_KEY_NAME`: The key name for the Terraform state file.

## Running the Workflows

### Terraform Apply Workflow

- Triggered on pull requests to the `Sami-PR-1` branch.
- Can be manually triggered using `workflow_dispatch`.
- Automatically applies changes on pushes to the `main` branch.

### Terraform Destroy Workflow

- Triggered on pushes to the `main` branch.
- Automatically destroys the infrastructure managed by Terraform.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
