resource "aws_s3_bucket" "remotestate" {
  bucket        = var.bucket_name
  force_destroy = true
  policy        = data.aws_iam_policy_document.s3_full
}

resource "aws_s3_bucket_acl" "remotestate-acl" {
  bucket = aws_s3_bucket.remotestate.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "remotestate-versioning" {
  bucket = aws_s3_bucket.remotestate.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "remotestate-policy" {
  bucket = aws_s3_bucket.remotestate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "remotestate-lock" {
  name           = "red30-tfstatelock"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_iam_user_policy" "remotestate-lock-policy" {
  name   = "terraform"
  user   = data.aws_iam_user.terraform.user_name
  policy = data.aws_iam_policy_document.dynamodb_full
}
