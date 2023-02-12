variable "region" {
  type        = string
  description = "The AWS region your resources will be deployed"
  default     = "us-east-1"
}

variable "bucket_name" {
  type        = string
  description = "Name of the bucket to store TF state in"
  default     = "Terraform-StateBucket"
}

variable "lock_table_name" {
  type        = string
  description = "Name of the DynamoDB Tabel to store TF state lock IDs"
  default     = "Terraform-StateLockTable"
}

locals {
  dynamo = {
    hash_key = "LockID"
    RCU      = 5
    WCU      = 5
  }
}
