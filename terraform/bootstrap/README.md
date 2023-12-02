# Terraform Bootstrap

This Terraform folder is dedicated to the initial setup of Terraform, orchestrating all the essential components for effective and safe state management within the AWS ecosystem.

## Primary Objectives

1. **Terraform State Bucket**: This S3 bucket is used to store the current state of your infrastructure as code. Storing the state in an S3 bucket allows for shared access, facilitating management and collaboration.
2. **DynamoDB Table for Locking**: To ensure the integrity of the Terraform state, a DynamoDB table is used to provide state locking, preventing race conditions and simultaneous modifications.
3. **Creating a Service User for CI Execution**: The Terraform configuration in this folder is also responsible for creating a service user in AWS. This user is specifically designed for Continuous Integration (CI) process execution, ensuring that automated operations have the appropriate permissions without compromising security.

## Setting Up Terraform Bootstrap

Creating a secure and efficient setup for managing infrastructure as code is paramount. This section details the steps to set up a Terraform bootstrap.

### Prerequisites

#### Installing AWS Vault

Follow the instructions on the [AWS Vault GitHub page](https://github.com/99designs/aws-vault).

#### Installing TFEnv

To install TFEnv, refer to the [TFEnv GitHub page](https://github.com/tfutils/tfenv).

#### Configuring AWS Vault

Configure AWS Vault by editing your AWS configuration file, typically located at `~/.aws/config`:

```plaintext
[profile <environment-name>]
sso_start_url = <your-sso-url>
sso_region = <your-region>
sso_account_id = <your-account-id>
sso_role_name = <your-role-name>
region = <your-region>
output = json
```

*Note: Replace the placeholders (< >) with appropriate values.*

Authenticate to your AWS account:

```bash
aws-vault login <environment-name>
```

### 1. Preparing the Initial Environment

**Before You Begin**:

- Create an IAM user with administrative permissions in AWS.
- Navigate to the `backend.tf` file and comment out the `backend {}` section for the initial Terraform execution.

Proceed with the initial Terraform setup:

```bash
terraform init
terraform plan -var-file=<environment-name>/variables.tfvars
terraform apply -var-file=<environment-name>/variables.tfvars -auto-approve
```

### 2. Understanding the Created Resources

This setup creates an S3 bucket for Terraform state storage and a DynamoDB table for state locking.

### 3. Configuring Terraform Backend

After creating the S3 and DynamoDB, uncomment the `backend {}` section in the `backend.tf` file.

```bash
terraform init -backend-config=<environment-name>/backend.conf -migrate-state -force-copy
```

### 4. Repeating for Other Environments

Authenticate to your AWS account for the specific environment:

```bash
aws-vault login <other-environment-name>
```

Clear local temporary Terraform files and repeat steps 1 and 3, replacing the placeholder with the specific environment name.

```bash
rm -rf .terraform terraform.tfstate.d/ .terraform.lock.hcl terraform.tfstate terraform.tfstate.backup
```

### 5. Creating a Service User for CI Execution and Configuring GitHub Secrets

An important function of this setup is to create a service user for Continuous Integration (CI) execution. This user's credentials will be generated and used for CI processes.

You'll need to configure the appropriate GitHub Secrets for AWS credentials. Example:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

These credentials are those of the service user created for CI execution. They can be obtained from the AWS Secrets Manager service. Make sure to configure these secrets in your GitHub repository before pushing any changes.
