resource "aws_iam_role" "dlake_twitterdataanalysis_raw_crawler_role" {
  name = "DlakeTwitterDataAnalysisRawCrawlerRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "glue.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "dlake_twitterdataanalysis_raw_crawler_policy" {
  name        = "DlakeTwitterDataAnalysisRawCrawlerPolicy"
  description = "Policies for Dlake Twitter Data Analysis Raw Crawler"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.dlake_twitterdataanalysis_raw.arn,
          "${aws_s3_bucket.dlake_twitterdataanalysis_raw.arn}/*"
        ]
      },
      {
        Action = [
          "glue:CreateTable",
          "glue:UpdateTable",
          "glue:DeleteTable",
          "glue:GetTable",
          "glue:GetTables",
          "glue:GetDatabase",
          "glue:GetDatabases"
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:us-east-1:${data.aws_caller_identity.current.account_id}:log-group:/aws-glue/crawlers:*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dlake_twitterdataanalysis_raw_crawler_policy_attachment" {
  policy_arn = aws_iam_policy.dlake_twitterdataanalysis_raw_crawler_policy.arn
  role       = aws_iam_role.dlake_twitterdataanalysis_raw_crawler_role.name
}
