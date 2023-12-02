resource "aws_glue_job" "q1_memory" {
  name              = "q1_memory"
  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = "2"
  role_arn          = aws_iam_role.mpp.arn

  command {
    script_location = "s3://${data.aws_s3_bucket.artifacts_bucket.id}/${aws_s3_object.q1_memory_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--additional-python-modules" = local.dependencies
  }
}

resource "aws_glue_job" "q2_memory" {
  name              = "q2_memory"
  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = "2"
  role_arn          = aws_iam_role.mpp.arn

  command {
    script_location = "s3://${data.aws_s3_bucket.artifacts_bucket.id}/${aws_s3_object.q2_memory_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--additional-python-modules" = local.dependencies
  }
}

resource "aws_glue_job" "q3_memory" {
  name              = "q3_memory"
  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = "2"
  role_arn          = aws_iam_role.mpp.arn

  command {
    script_location = "s3://${data.aws_s3_bucket.artifacts_bucket.id}/${aws_s3_object.q3_memory_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--additional-python-modules" = local.dependencies
  }
}

resource "aws_glue_job" "q1_time" {
  name              = "q1_time"
  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = "2"
  role_arn          = aws_iam_role.mpp.arn

  command {
    script_location = "s3://${data.aws_s3_bucket.artifacts_bucket.id}/${aws_s3_object.q1_time_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--additional-python-modules" = local.dependencies
  }
}

resource "aws_glue_job" "q2_time" {
  name              = "q2_time"
  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = "2"
  role_arn          = aws_iam_role.mpp.arn

  command {
    script_location = "s3://${data.aws_s3_bucket.artifacts_bucket.id}/${aws_s3_object.q2_time_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--additional-python-modules" = local.dependencies
  }
}

resource "aws_glue_job" "q3_time" {
  name              = "q3_time"
  glue_version      = "4.0"
  worker_type       = "G.1X"
  number_of_workers = "2"
  role_arn          = aws_iam_role.mpp.arn

  command {
    script_location = "s3://${data.aws_s3_bucket.artifacts_bucket.id}/${aws_s3_object.q3_time_script.key}"
    python_version  = "3"
  }

  default_arguments = {
    "--additional-python-modules" = local.dependencies
  }
}
