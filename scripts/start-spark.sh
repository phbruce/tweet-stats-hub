#!/bin/bash

export SPARK_SUBMIT_OPTS="\
-Dspark.hadoop.fs.s3a.access.key=minio \
-Dspark.sql.repl.eagerEval.enabled=true \
-Dspark.hadoop.fs.s3a.secret.key=minio123 \
-Dspark.hadoop.fs.s3a.path.style.access=true \
-Dspark.hadoop.fs.s3a.endpoint=http://minio:9000 \
-Dspark.hadoop.fs.s3a.impl=org.apache.hadoop.fs.s3a.S3AFileSystem"


case $SERVICE in
  master)
    /opt/spark/bin/spark-class org.apache.spark.deploy.master.Master
    ;;
  worker)
    /opt/spark/bin/spark-class org.apache.spark.deploy.worker.Worker \
    $SPARK_MASTER
    ;;
  jupyter)
    /opt/spark/bin/pyspark \
    --master $SPARK_MASTER
    ;;
  *)
    echo "Service not recognized: $SERVICE"
    exit 1
    ;;
esac
