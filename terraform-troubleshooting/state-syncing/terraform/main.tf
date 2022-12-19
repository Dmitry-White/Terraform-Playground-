terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = "~> 1.0"
}

provider "aws" {
  profile = "default"
  region  = var.region
}

data "aws_ami" "amazon_linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_instance" "web_app" {
  ami           = data.aws_ami.amazon_linux.id
  subnet_id     = "<DUMMY_VALUE>"
  instance_type = "t3.micro"

  tags = {
    Name = "${var.name}-justice"
  }
}