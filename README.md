# Twitter Data Analysis Project

## Overview

This project delves into a comprehensive analysis of the `farmers-protest-tweets-2021-2-4.json` dataset, publicly accessible for research and educational purposes. The dataset encompasses a broad spectrum of Twitter data, encapsulating various elements such as tweet content, conversation IDs, language, engagement metrics, and more, offering a multifaceted view of social media dynamics.

### Dataset Insights

The dataset's complexity is highlighted by its dynamic schema, particularly in the `quotedTweet` field, which reflects the layered nature of Twitter conversations. This presents both analytical opportunities and technical challenges.

#### Approaches to Schema Dynamics

To efficiently process this dynamic data, we propose two methodologies:

- **One Big Table (OBT)** Method: A flattening strategy simplifying data handling.
    - **Advantages**: Streamlines data operations.
    - **Limitations**: Potentially increases redundancy and resource demands.

- **Dimensional Modelling** Technique: Segregates data into dimensions and facts.
    - **Advantages**: Enhances readability and query performance.
    - **Limitations**: May introduce computational complexities in distributed computing environments like Apache Spark.

The choice of strategy will be guided by project-specific requirements, data volume, and available resources.

## Development Ecosystem

Our project environment leverages Docker containers, each tailored for specific roles in data processing and analysis:

### Core Components

- **Apache Spark & Hadoop**: Utilizing Spark version 3.3.3 and Hadoop version 3 for scalable data processing and storage. Configured on a `openjdk:11-jdk-slim` base image for optimal performance.
- **Python & JupyterLab**: Python 3 and JupyterLab facilitate scripting and interactive data analysis.
- **Dependencies Management**: Managed through a `requirements.txt` file for Python libraries.
- **Networking Configuration**: Ports are mapped for Spark UI and JupyterLab access.

### Docker Compose Integration

Our `docker-compose.yml` orchestrates a multi-container setup, integrating components like Minio for local object storage and separate services for Spark's master-worker architecture.

## Quickstart Guide

### Setup Requirements

- Docker and Docker Compose installation.
- Terraform for optional cloud infrastructure setup.

### Installation Steps

1. Repository cloning:
   ```sh
   git clone https://github.com/phbruce/twitter-data-analysis.git
   ```
2. Navigate to the project's root directory.
3. Initiate the Docker Compose setup:
   ```sh
   docker-compose up -d
   ```

## Operational Guide

Post-setup, users can access the Jupyter Notebook interface and execute predefined analysis scripts. Detailed instructions are provided within the Docker container logs.

## Project Highlights

- **Data Ingestion and Processing**: Efficient handling of large datasets through Apache Spark.
- **Cloud Integration**: Support for AWS and GCP via Terraform.
- **Analytical Tools**: Custom Python functions for targeted data insights.

## Comprehensive Documentation

Each module and function within the project is accompanied by detailed documentation, providing clarity and guidance for users and developers alike.

## Collaborative Development

We encourage contributions following the [GitFlow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow), ensuring a structured and efficient collaboration process.

## Licensing and Acknowledgments

The project is released under the MIT License, and we extend our gratitude to the creators and maintainers of Minio, Apache Spark, Docker, and Terraform for their invaluable contributions to the open-source community.
