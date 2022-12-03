# Terraform relies on plugins called providers to interact with cloud providers,
# SaaS providers, and other APIs.
# Each provider adds a set of resource types and/or data sources that Terraform can manage.

terraform {
  required_providers {
    # No version mentioned for a particular provider - downloads the latest one
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Resources that don't set the provider meta-argument
# will use the default provider configuration
# that matches the first word of the resource type name.
provider "aws" {
  region = "us-east-1"
}

# You can optionally define multiple configurations for the same provider, 
# and select which one to use on a per-resource or per-module basis. 
# The primary reason for this is to support multiple regions for a cloud platform;
# other examples include targeting multiple Docker hosts, multiple Consul hosts, etc.
provider "aws" {
  alias  = "us-west-2"
  region = "us-west-2"
  
  # The version meta-argument in provider configurations is deprecated.
  # In Terraform > 0.13, always declare provider version constraints
  # in the terraform.required_providers block.
  # version = "value"
}


resource "aws_sns_topic" "topic-us-east" {
  name = "topic-us-east"
}

# When Terraform needs the name of a provider configuration,
# it expects a reference of the form <PROVIDER NAME>.<ALIAS>.
# In this example, aws.west would refer to the provider with the us-west-2 region.
resource "aws_sns_topic" "topic-us-west" {
  provider = aws.us-west-2
  name     = "topic-us-west"
}
