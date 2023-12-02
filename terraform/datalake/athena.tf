resource "aws_athena_workgroup" "twitter_data_analytics_v1" {
  name = "twitter_data_analytics_v1"

  configuration {
    enforce_workgroup_configuration = false

    result_configuration {
      output_location = "s3://${aws_s3_bucket.athena_results.bucket}/twitter_data_analytics_v1/"
    }
  }
}
