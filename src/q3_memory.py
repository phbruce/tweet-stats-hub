import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

from pyspark.sql import DataFrame, types as T
from pyspark.sql import functions as F

import re
import demoji
import pandas as pd
from typing import List, Tuple

## @params: [JOB_NAME]
args = getResolvedOptions(sys.argv, ['JOB_NAME'])

sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args['JOB_NAME'], args)
job.commit()

class DataPrep:
    FIELD_SEPARATOR: str = '__'

    @staticmethod
    def flatten_struct(schema: T.StructType, prefix: str = '') -> List[str]:
        """
        Flattens a Spark DataFrame schema, transforming nested structures into a flat list of column names.

        Args:
            schema (T.StructType): The schema of the DataFrame to be flattened.
            prefix (str, optional): A prefix to prepend to each column name. Defaults to an empty string.

        Returns:
            List[str]: A list of column names with nested structures flattened.
        """
        flat_fields: List[str] = []
        for field in schema.fields:
            col_name: str = f'{prefix}{DataPrep.FIELD_SEPARATOR}{field.name}' if prefix else field.name

            if isinstance(field.dataType, T.StructType):
                flat_fields += DataPrep.flatten_struct(field.dataType, col_name)
            else:
                flat_fields.append(col_name)

        return flat_fields

    @staticmethod
    def select_and_rename(df: DataFrame, flat_fields: List[str]) -> DataFrame:
        """
        Renames columns in a DataFrame based on a list of flat field names, replacing the separator with a dot.

        Args:
            df (DataFrame): The DataFrame whose columns need to be renamed.
            flat_fields (List[str]): A list of flat field names to be used for renaming.

        Returns:
            DataFrame: A DataFrame with columns renamed as specified in flat_fields.
        """
        for field in flat_fields:
            df = df.withColumn(field, F.col(field.replace(DataPrep.FIELD_SEPARATOR, '.')))

        return df.select(flat_fields)

    @staticmethod
    def partition_by_date(df: DataFrame, date_col: str) -> None:
        """
        Partitions a DataFrame by a formatted date string.

        Args:
            df (DataFrame): The DataFrame to be partitioned.
            date_col (str): The name of the column to be used for partitioning.

        Returns:
            None
        """
        formatted_date_col: F.Column = F.date_format(date_col, 'yyyy-MM-dd').alias('formatted_date')

        df = df.withColumn('dt', formatted_date_col)

        df.write.mode('overwrite').partitionBy('dt').parquet(
            's3://dlake-twitterdataanalysis-staged/farmers-protest-tweets'
        )

    @staticmethod
    def salt(df: DataFrame, column_to_salt: str, salt_range: int) -> DataFrame:
        """
        Applies salting to a specific column of a DataFrame without using a UDF.

        Args:
            df (DataFrame): Input DataFrame.
            column_to_salt (str): Name of the column to apply salting.
            salt_range (int): Number of different salt values to be used.

        Returns:
            DataFrame with a new column containing 'salted' values.
        """
        salt_expr = F.expr(
            f"concat({column_to_salt}, '_', cast(rand()*{salt_range} as int))"
        )

        return df.withColumn(f"{column_to_salt}_salted", salt_expr)


df = spark.read.json('s3://dlake-twitterdataanalysis-raw/seed_v1/farmers-protest-tweets-2021-2-4.json')
DataPrep.partition_by_date(df, 'date')


def q3_memory(file_path: str) -> List[Tuple[str, int]]:
    raw = spark.read.parquet(file_path)

    flattened = DataPrep.flatten_struct(raw.schema)

    df = DataPrep.select_and_rename(raw, flattened)

    tweets_df_with_mentions = df.select(
        '*',
        F.explode('mentionedUsers').alias('mentioned_user')
    )

    top10_influential_users = tweets_df_with_mentions.groupBy(
        'mentioned_user.username'
    ).count().orderBy(
        'count',
        ascending=False
    ).limit(10)

    result_data = top10_influential_users.collect()

    result = [(row['username'], row['count']) for row in result_data]

    return result


q3_memory('s3://dlake-twitterdataanalysis-staged/farmers-protest-tweets/')
