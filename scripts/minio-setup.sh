#!/bin/sh

# Constants for buckets
RAW_BUCKET="raw"
STAGED_BUCKET="staged"
FILE_NAME="farmers-protest-tweets-2021-2-4.json"
FILE_PATH="/unzipped/$FILE_NAME"
MINIO_ALIAS="myminio"
MINIO_URL="http://minio:9000"
MINIO_USER="minio"
MINIO_PASS="minio123"

# Wait for MinIO to start
echo 'Waiting for MinIO...'
until mc alias set $MINIO_ALIAS $MINIO_URL $MINIO_USER $MINIO_PASS; do
  echo 'Waiting for MinIO to start...'
  sleep 1
done
echo 'MinIO started'

# Function to create a bucket if it doesn't exist
create_bucket_if_not_exists() {
    BUCKET_NAME=$1
    if mc ls $MINIO_ALIAS | grep -q $BUCKET_NAME; then
      echo "Bucket $BUCKET_NAME already exists."
    else
      echo "Creating bucket $BUCKET_NAME."
      mc mb $MINIO_ALIAS/$BUCKET_NAME
    fi
}

# Create raw and staged buckets
create_bucket_if_not_exists $RAW_BUCKET
create_bucket_if_not_exists $STAGED_BUCKET

# Check if the file already exists in the raw bucket
if mc ls $MINIO_ALIAS/$RAW_BUCKET | grep -q $FILE_NAME; then
  echo "File $FILE_NAME already exists in bucket $RAW_BUCKET. Skipping upload."
else
  echo "Uploading $FILE_NAME to MinIO..."
  mc cp $FILE_PATH $MINIO_ALIAS/$RAW_BUCKET/
  echo 'File uploaded'
fi
