resource "aws_s3_bucket" "red30-tfremotestate" {
  bucket        = var.bucket_name
  force_destroy = true
  acl           = "private"

  versioning {
    enabled = true
  }

  policy = data.aws_iam_policy_document.s3_full
}

resource "aws_s3_bucket_public_access_block" "red30-tfremotestate" {
  bucket = aws_s3_bucket.red30-tfremotestate.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "tf_db_statelock" {
  name           = "red30-tfstatelock"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_iam_user_policy" "terraform_user_dbtable" {
  name   = "terraform"
  user   = data.aws_iam_user.terraform.user_name
  policy = data.aws_iam_policy_document.dynamodb_full
}
