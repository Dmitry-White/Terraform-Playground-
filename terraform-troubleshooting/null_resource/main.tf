terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = var.instance_ami
  instance_type = "t3.micro"
  subnet_id     = var.subnet_id

  tags = {
    Name = var.instance_name
  }
}
