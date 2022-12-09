terraform {
  required_version = ">= 0.14.9"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.25"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.17"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "<AWS_PROFILE>"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}