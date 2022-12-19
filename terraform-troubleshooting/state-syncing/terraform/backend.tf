terraform {
  backend "s3" {
    encrypt = true
    bucket = "hall-of-buckets1"
    dynamodb_table = "terraform-state-lock-dynamo"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}