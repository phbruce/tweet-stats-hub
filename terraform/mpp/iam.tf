resource "aws_iam_role" "mpp" {
  name = "MPPRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "glue_service" {
  role       = aws_iam_role.mpp.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

resource "aws_iam_policy" "s3_access_policy" {
  name        = "MPPS3AccessPolicy"
  description = "Policy for MPP role to access S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Effect = "Allow",
        Resource = [
          "arn:aws:s3:::dlake-twitterdataanalysis-raw/*",
          "arn:aws:s3:::dlake-twitterdataanalysis-staged/*",
          "arn:aws:s3:::dlake-twitterdataanalysis-analytics/*",
          "arn:aws:s3:::dlake-twitterdataanalysis-artifacts/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access_policy_attachment" {
  role       = aws_iam_role.mpp.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}
