terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }

  required_version = ">= 0.13"

  backend "s3" {
    profile = "AWS_PROFILE"
    region  = "AWS_REGION"
    key     = "terraform.tfstate"
    bucket  = "BUCKET_NAME"
  }
}

provider "docker" {}