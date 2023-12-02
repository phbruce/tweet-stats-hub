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


def q2_time(file_path: str) -> List[Tuple[str, int]]:
    emoji_pattern = r'[\U0001F1E0-\U0001F1FF\U0001F300-\U0001F5FF\U0001F600-\U0001F64F\U0001F680-\U0001F6FF\U0001F700-\U0001F77F\U0001F780-\U0001F7FF\U0001F800-\U0001F8FF\U0001F900-\U0001F9FF\U0001FA00-\U0001FA6F\U0001FA70-\U0001FAFF\U00002702-\U000027B0\U000024C2-\U0001F251]+'

    raw = spark.read.parquet(file_path)

    flattened = DataPrep.flatten_struct(raw.schema)

    df = DataPrep.select_and_rename(raw, flattened)

    @F.pandas_udf(T.ArrayType(T.StringType()))
    def extract_emojis(texts: pd.Series) -> pd.Series:
        def extract(text):
            potential_emojis = re.findall(emoji_pattern, text)
            emojis = []

            for emoji in potential_emojis:
                extracted = demoji.findall(emoji)
                emojis.extend(extracted.keys())
            return emojis

        return texts.apply(extract)

    emojis_df = df.withColumn('emojis', extract_emojis(F.col('content')))

    emojis_df.cache()

    emojis_flat = emojis_df.withColumn('emoji', F.explode('emojis')).repartition("emoji")

    emojis_count = emojis_flat.groupBy('emoji').count()

    top_10_emojis = emojis_count.orderBy(F.col('count').desc()).limit(10)

    result_data = top_10_emojis.collect()

    result = [(row['emoji'], row['count']) for row in result_data]

    return result


q2_time('s3://dlake-twitterdataanalysis-staged/farmers-protest-tweets/')
