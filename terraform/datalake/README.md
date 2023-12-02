# Terraform Data Lake Setup for Twitter Data Analysis Cases

This Terraform folder focuses on orchestrating the setup of a Data Lake for Twitter Data Analysis Cases using Terraform. It facilitates the smooth management, maintenance, and scalability of your data storage on AWS S3.

## Primary Objectives

1. **S3 Buckets Creation**: Define and create distinct buckets for raw, staged, and analytics data with necessary configurations.
2. **Data Lifecycle Management**: Apply lifecycle rules to the data stored in the buckets, transitioning them to different storage classes based on defined criteria.
3. **Encryption & Access Control**: Ensure data at rest is encrypted and that buckets have the correct access control policies.

## Setting Up Data Lake

Ensure a seamless setup of your Data Lake on AWS S3 with the following steps:

### Prerequisites

#### Installing AWS Vault

Follow the instructions on the [AWS Vault GitHub page](https://github.com/99designs/aws-vault).

#### Installing TFEnv

To manage multiple Terraform versions, you can use TFEnv. Installation instructions are available on the [TFEnv GitHub page](https://github.com/tfutils/tfenv).

#### Configuring AWS Vault

If integrating with AWS resources, configure AWS Vault by editing the AWS configuration file, typically located at `~/.aws/config`:

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

#### Initializing Terraform

```bash
terraform init
```

#### Planning and Applying Changes

Review the proposed changes and apply them:

```bash
terraform plan -var-file=<environment-name>/variables.tfvars
terraform apply -var-file=<environment-name>/variables.tfvars -auto-approve
```

### Exploring Created Resources

After setup, you'll have three S3 buckets for:

- **Raw Data**: `dlake-twitterdataanalysis-raw`
- **Staged Data**: `dlake-twitterdataanalysis-staged`
- **Analytics Data**: `dlake-twitterdataanalysis-analytics`

These buckets have distinct lifecycles and access controls for optimal data management.
