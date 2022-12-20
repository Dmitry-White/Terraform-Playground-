terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  backend "s3" {
    bucket         = "Terraform-StateBucket"
    dynamodb_table = "Terraform-StateLockTable"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }

  required_version = "~> 1.0"
}

provider "aws" {
  region = var.region
}
