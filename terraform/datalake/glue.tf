resource "aws_glue_catalog_database" "dlake_twitterdataanalysis_raw" {
  name        = "dlake_twitterdataanalysis_raw"
  description = "Database for dlake twitter data analysis raw data"
}

resource "aws_glue_catalog_database" "dlake_twitterdataanalysis_staged" {
  name        = "dlake_twitterdataanalysis_staged"
  description = "Database for dlake twitter data analysis staged data"
}

resource "aws_glue_catalog_database" "dlake_twitterdataanalysis_analytics" {
  name        = "dlake_twitterdataanalysis_analytics"
  description = "Database for dlake twitter data analysis analytics data"
}

resource "aws_glue_crawler" "dlake_twitterdataanalysis_raw_crawler" {
  name          = "dlake-twitterdataanalysis-raw-seed-v1-crawler"
  database_name = "dlake_twitterdataanalysis_raw"

  role = aws_iam_role.dlake_twitterdataanalysis_raw_crawler_role.arn

  s3_target {
    path = "s3://dlake-twitterdataanalysis-raw/seed_v1/"
  }
}
