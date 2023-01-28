# //////////////////////////////
# REQUIRED
# //////////////////////////////
variable "aws_access_key" {}

variable "aws_secret_key" {}

# //////////////////////////////
# OPTIONAL
# //////////////////////////////
variable "bucket_name" {
  default = "red30-tfstate"
}

# //////////////////////////////
# DATA
# //////////////////////////////
data "aws_iam_user" "terraform" {
  user_name = "terraform"
}

data "aws_iam_policy_document" "s3_full" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [data.aws_iam_user.terraform.arn]
    }
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.bucket_name}/*"
    ]
  }
}

data "aws_iam_policy_document" "dynamodb_full" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:*"
    ]
    resources = [
      aws_dynamodb_table.remotestate-lock.arn
    ]
  }
}
