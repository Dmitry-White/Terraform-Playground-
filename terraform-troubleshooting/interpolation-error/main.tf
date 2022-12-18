terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.24.1"
    }
  }
  required_version = "~> 1.0"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "web_app" {
  ami                    = <DUMMY VALUE>
  subnet_id              = <DUMMY VALUE>
  instance_type          = "t3.micro"
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = $var.name-justice
  }
}
