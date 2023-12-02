resource "aws_s3_bucket" "twitterdataanalysis_terraform_state_bucket" {
  bucket = "${var.bucket_prefix}-${var.environment}"
}

resource "aws_s3_bucket_ownership_controls" "twitterdataanalysis_terraform_state_bucket_ownership_controls" {
  bucket = aws_s3_bucket.twitterdataanalysis_terraform_state_bucket.id

  rule {
    object_ownership = var.object_ownership
  }
}
