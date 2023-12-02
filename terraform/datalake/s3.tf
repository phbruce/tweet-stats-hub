resource "aws_s3_bucket" "dlake_twitterdataanalysis_raw" {
  bucket = "dlake-twitterdataanalysis-raw"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dlake_twitterdataanalysis_raw_encryption" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_raw.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "dlake_twitterdataanalysis_raw_lifecycle" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_raw.bucket

  rule {
    id     = "transition_to_ia"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "dlake_twitterdataanalysis_raw_ownership" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_raw.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dlake_twitterdataanalysis_raw_acl" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_raw.bucket
  acl    = "private"
}

resource "aws_s3_bucket" "dlake_twitterdataanalysis_staged" {
  bucket = "dlake-twitterdataanalysis-staged"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dlake_twitterdataanalysis_staged_encryption" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_staged.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "dlake_twitterdataanalysis_staged_lifecycle" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_staged.bucket

  rule {
    id     = "transition_to_ia"
    status = "Enabled"

    transition {
      days          = 60
      storage_class = "STANDARD_IA"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "dlake_twitterdataanalysis_staged_ownership" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_staged.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dlake_twitterdataanalysis_staged_acl" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_staged.bucket
  acl    = "private"
}

resource "aws_s3_bucket" "dlake_twitterdataanalysis_analytics" {
  bucket = "dlake-twitterdataanalysis-analytics"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dlake_twitterdataanalysis_analytics_encryption" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_analytics.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "dlake_twitterdataanalysis_analytics_lifecycle" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_analytics.bucket

  rule {
    id     = "transition_to_glacier"
    status = "Enabled"

    transition {
      days          = 365
      storage_class = "GLACIER"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "dlake_twitterdataanalysis_analytics_ownership" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_analytics.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dlake_twitterdataanalysis_analytics_acl" {
  bucket = aws_s3_bucket.dlake_twitterdataanalysis_analytics.bucket
  acl    = "private"
}

resource "aws_s3_bucket" "athena_results" {
  bucket = "dlake-twitterdataanalysis-athena-results"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dlake_twitterdataanalysis_athena_results_encryption" {
  bucket = aws_s3_bucket.athena_results.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "dlake_twitterdataanalysis_athena_results_ownership" {
  bucket = aws_s3_bucket.athena_results.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dlake_twitterdataanalysis_athena_results_acl" {
  bucket = aws_s3_bucket.athena_results.bucket
  acl    = "private"
}

resource "aws_s3_bucket" "artifacts" {
  bucket = "dlake-twitterdataanalysis-artifacts"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dlake_twitterdataanalysis_artifacts_encryption" {
  bucket = aws_s3_bucket.artifacts.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "dlake_twitterdataanalysis_artifacts_ownership" {
  bucket = aws_s3_bucket.artifacts.bucket

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "dlake_twitterdataanalysis_artifacts_acl" {
  bucket = aws_s3_bucket.artifacts.bucket
  acl    = "private"
}
