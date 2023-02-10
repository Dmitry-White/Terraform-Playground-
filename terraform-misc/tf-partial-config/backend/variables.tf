# //////////////////////////////
# INPUT
# //////////////////////////////
variable "bucket_name" {
  default = "tf-partial-config-tfstate"
}

variable "table_name" {
  default = "tf-partial-config-tfstatelock"
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
  table_policy_name = "terraform"
}
