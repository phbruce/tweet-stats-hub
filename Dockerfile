FROM openjdk:11-jdk-slim

ENV SPARK_VERSION=3.3.3
ENV SPARK_HOME=/opt/spark
ENV HADOOP_VERSION=3
ENV HADOOP_HOME=/opt/hadoop
ENV PATH=$PATH:$SPARK_HOME/bin:$HADOOP_HOME/bin

RUN apt-get update && apt-get install -y python3 python3-pip wget
RUN python3 -m pip install --upgrade pip
RUN pip install jupyterlab

COPY requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN wget https://downloads.apache.org/spark/spark-$SPARK_VERSION/spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz \
    && tar -xvf spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz \
    && mv spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION $SPARK_HOME \
    && rm spark-$SPARK_VERSION-bin-hadoop$HADOOP_VERSION.tgz

RUN wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.2/hadoop-aws-3.3.2.jar -P $SPARK_HOME/jars/
RUN wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.597/aws-java-sdk-bundle-1.12.597.jar -P $SPARK_HOME/jars/

EXPOSE 4040 8080 7077 8888

COPY scripts/start-spark.sh /start-spark.sh
RUN chmod +x /start-spark.sh

CMD ["/start-spark.sh"]
