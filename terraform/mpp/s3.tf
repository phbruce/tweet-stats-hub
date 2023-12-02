resource "aws_s3_object" "q1_memory_script" {
  bucket = data.aws_s3_bucket.artifacts_bucket.id
  key    = "mpp/q1_memory.py"
  source = "${path.module}/q1_memory.py"

  etag = filemd5("${path.module}/q1_memory.py")
}

resource "aws_s3_object" "q2_memory_script" {
  bucket = data.aws_s3_bucket.artifacts_bucket.id
  key    = "mpp/q2_memory.py"
  source = "${path.module}/q2_memory.py"

  etag = filemd5("${path.module}/q2_memory.py")
}

resource "aws_s3_object" "q3_memory_script" {
  bucket = data.aws_s3_bucket.artifacts_bucket.id
  key    = "mpp/q3_memory.py"
  source = "${path.module}/q3_memory.py"

  etag = filemd5("${path.module}/q3_memory.py")
}

resource "aws_s3_object" "q1_time_script" {
  bucket = data.aws_s3_bucket.artifacts_bucket.id
  key    = "mpp/q1_time.py"
  source = "${path.module}/q1_time.py"

  etag = filemd5("${path.module}/q1_time.py")
}

resource "aws_s3_object" "q2_time_script" {
  bucket = data.aws_s3_bucket.artifacts_bucket.id
  key    = "mpp/q2_time.py"
  source = "${path.module}/q2_time.py"

  etag = filemd5("${path.module}/q2_time.py")
}

resource "aws_s3_object" "q3_time_script" {
  bucket = data.aws_s3_bucket.artifacts_bucket.id
  key    = "mpp/q3_time.py"
  source = "${path.module}/q3_time.py"

  etag = filemd5("${path.module}/q3_time.py")
}
