resource "aws_iam_role" "server_bucket_role" {
  name = local.server.bucket_role_name

  assume_role_policy = data.aws_iam_policy_document.server_assume_role.json

  tags = {
    Name  = local.server.bucket_role_name
    Scope = local.scope
  }
}

resource "aws_iam_role_policy" "server_bucket_policy" {
  name = local.server.bucket_role_policy
  role = aws_iam_role.server_bucket_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${var.server_bucket}",
          "arn:aws:s3:::${var.server_bucket}/*"
        ]
      },
    ]
  })
}

resource "aws_iam_instance_profile" "server_profile" {
  name = local.server.profile
  role = aws_iam_role.server_bucket_role.name
  
  tags = {
    Name  = local.server.profile
    Scope = local.scope
  }
}
