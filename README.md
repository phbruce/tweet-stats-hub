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

### Docker Compose Configuration and Data Management

Our `docker-compose.yml` setup plays a pivotal role in orchestrating our development environment, ensuring all necessary services are deployed and configured efficiently and automatically.

#### Service Details

- **MinIO**: Used for object storage. We create two buckets - `raw` and `staged` - for managing data at different stages of the processing pipeline. Volumes and ports are configured to ensure data persistence and accessibility.

- **Apache Spark**: Configured with a `master` and `workers` for distributed data processing. Integration with the Jupyter Notebook facilitates interactive data analysis.

- **Jupyter Notebook**: Set up to interact with Spark and perform analyses in a notebook environment. Volumes are mapped to ensure notebooks and data are easily accessible and persisted locally.

#### MinIO Configuration and Bucket Creation

The `minio-setup` service is especially crucial. It waits for MinIO to become operational and then uses the MinIO client (`mc`) to set up an alias (`myminio`) for our MinIO server. Once set up, it creates two buckets:

- **`Raw` Bucket**: Intended for the initial storage of raw data, such as the `farmers-protest-tweets-2021-2-4.json` dataset.
- **`Staged` Bucket**: Used to store data that has undergone initial processing stages.

This approach ensures that data is efficiently managed from ingestion to advanced processing.

#### Dependency Management and Dataset

The `requirements.txt` file manages all necessary dependencies for the worker, master, and Jupyter services, ensuring a consistent and efficient development environment. Additionally, our workflow includes local downloading of the dataset for preliminary analysis and subsequent upload to the `raw` bucket in MinIO, initiating the data processing pipeline.

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

### System Performance and Requirements
- To ensure the smooth operation of the project, it is recommended to allocate a minimum of 16GB of memory to Docker. This is essential for handling the complex data processing tasks efficiently in the local development environment.

Including this detail helps in setting clear expectations and prerequisites for users who wish to replicate or contribute to your project.

### Monitoring with Ganglia in Development Environment

#### Ganglia Configuration

- **Ganglia Integration**: Our development environment also includes Ganglia, a scalable distributed monitoring system for high-performance computing systems such as clusters and grids.
- **Accessing Metrics**: You can analyze metrics in the development environment through the URL `localhost:8099`.

### Accessing Jupyter Notebook

#### Jupyter Notebook Setup

- **Jupyter Interface**: JupyterLab is configured for interactive data analysis and scripting with integration to Apache Spark.
- **Accessing Jupyter**: After starting the Docker Compose setup, JupyterLab will be accessible. The console will display an HTTP address with a token. You can access JupyterLab by holding `Ctrl` and clicking the URL, which will open in your default browser.

## Project Highlights

- **Data Ingestion and Processing**: Efficient handling of large datasets through Apache Spark.
- **Cloud Integration**: Support for AWS via Terraform.
- **Analytical Tools**: Custom Python functions for targeted data insights.

## Comprehensive Documentation

Each module and function within the project is comprehensively documented within the Jupyter Notebook file located in `src/twitter-data-analysis`. This detailed documentation provides clarity and guidance for users and developers alike, ensuring a thorough understanding of the project's functionality and structure.

## Collaborative Development

We encourage contributions following the [GitFlow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow), ensuring a structured and efficient collaboration process.

## Licensing and Acknowledgments

The project is released under the MIT License, and we extend our gratitude to the creators and maintainers of Minio, Apache Spark, Docker, and Terraform for their invaluable contributions to the open-source community.
