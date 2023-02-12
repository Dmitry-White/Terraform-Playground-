# //////////////////////////////
# INPUT
# //////////////////////////////
variable "environment" {
  type        = string
  description = "Deployment Environment"
}

variable "region" {
  type        = string
  description = "Deployment region"
}

variable "bucket_name" {
  type        = string
  description = "Deployment S3 bucket"
}

variable "table_name" {
  type        = string
  description = "Deployment State Lock table"
}

# //////////////////////////////
# DATA
# //////////////////////////////
data "aws_iam_user" "terraform" {
  user_name = local.iam_user_name
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

# //////////////////////////////
# LOCAL
# //////////////////////////////
locals {
  iam_user_name     = "TerraformCloud"
  table_policy_name = "terraform-dynamodb"

  dynamo = {
    hash_key = "LockID"
    RCU      = 5
    WCU      = 5
  }
}
