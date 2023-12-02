# Terraform Setup with AWS Glue Jobs for Twitter Data Analysis

This folder outlines the process of configuring Terraform for setting up AWS Glue jobs to perform Twitter data analysis. The primary goals are to configure a Glue crawler to track the source data, create six Glue jobs each with a specific objective, and enable the uploading of local files to S3, which will be used in each job.

## Primary Objectives

1. **Local File Upload to S3**: Enabling the upload of specific Python scripts to S3 for use in Glue jobs.

2. **Glue Jobs Creation**: Developing six distinct AWS Glue jobs, each tailored for a specific analysis objective. These jobs are:
   - **q1_memory**: Most Active Users and Days with Highest Tweet Activity with a Focus on Memory Efficiency.

   - **q1_time**: Most Active Users and Days with Highest Tweet Activity with a Focus on Time Efficiency.

   - **q2_memory**: Emoji Usage in Tweets with a Focus on Memory Efficiency.

   - **q2_time**: Emoji Usage in Tweets with a Focus on Time Efficiency.

   - **q3_memory**: Identifying Top 10 Influential Twitter Users Based on Mentions with a Focus on Memory Efficiency.

   - **q3_time**: Identifying Top 10 Influential Twitter Users Based on Mentions with a Focus on Time Efficiency.
3. **Glue Crawler Configuration**: Setting up a Glue crawler to track the source data in S3.

## Project Overview

The Terraform setup is designed to automate the deployment and configuration of AWS resources necessary for Twitter data analysis. This includes the creation of AWS Glue jobs and a crawler, along with the management of dependencies and local file uploads to S3.

### Key Objectives

1. **Glue Crawler Configuration**: Setting up a Glue crawler to track the source data in S3.
2. **Glue Jobs Creation**: Developing six distinct AWS Glue jobs, each tailored for a specific analysis objective.
3. **Local File Upload to S3**: Enabling the upload of specific Python scripts to S3 for use in Glue jobs.

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

### Glue Jobs and Crawler Setup

To ensure the system functions as expected, it's crucial to upload a specific file to the appropriate S3 bucket. Here are the detailed steps:

1. **Download the File**: First, you need to download the file from the following link: [Download File](https://drive.google.com/file/d/1ig2ngoXFTxP5Pa8muXo02mDTFexZzsis/view?usp=sharing). This file is critical for the initial data setup.

2. **Upload the File to S3**: After downloading, the file should be uploaded to the designated S3 bucket, specifically into the `seed_v1` folder within the `raw` bucket. This step is essential to ensure that the data is in the right place to be processed by AWS Glue jobs.

   You can use the AWS Management Console, AWS CLI, or any other method you prefer that supports file uploads to AWS S3 for this purpose.

#### Performing the Analysis with Glue Jobs

1. **Access the AWS Glue Console**: After the file has been uploaded to S3, the next step is to access the AWS Glue console. You can do this by navigating to the AWS Management Console and searching for "Glue" in the search bar.

2. **Find the Job**: Once you're in the AWS Glue console, you can find the job by navigating to the "Jobs" section on the left-hand side of the screen. You should see a list of jobs, including the six jobs created by Terraform.

3. **Select the Job**: Select the job you want to run by clicking on it. This will take you to the job details page, where you can see the job's configuration and status.

4. **Run the Job**: To run the job, click on the "Actions" button and select "Run job." This will start the job and display its status in the "Status" column.

5. **View the Runs**: To view the job runs, click on the "Runs" tab at the top of the page. This will display a list of all the runs for this job, including the one you just started.

#### Performing the Analysis with Athena

1. **Run the Glue Crawler**: Once the file is on S3, the next step is to run the configured AWS Glue crawler for this bucket. The crawler will scan the data, extract the schema, and create tables in the Glue data catalog, which can be later queried.

2. **Query Data in Athena**: After the crawler has run, the processed data will be available in Amazon Athena. Athena allows you to run SQL queries on the data stored in S3 using the tables created by the Glue crawler.

3. **Verification and Analysis**: Finally, it's recommended to verify whether the data has been processed correctly and is available for querying in Athena. Once confirmed, you can proceed with the desired analyses using AWS tools and services.
