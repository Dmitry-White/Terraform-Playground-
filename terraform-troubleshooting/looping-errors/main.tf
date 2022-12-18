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
  for_each               = aws_security_group.*.id
  ami                    = "<DUMMY VALUE>"
  subnet_id              = "<DUMMY VALUE>"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [each.id]
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "${var.name}-justice"
  }
}

resource "aws_security_group" "sg_ping" {
   name                      = "Allow Ping"
   vpc_id                    = "<DUMMY VALUE>"
}

resource "aws_security_group" "sg_8080" {
   name                      = "Allow 8080"
   vpc_id                    = "<DUMMY VALUE>"
}

 resource "aws_security_group_rule" "sg_ping" {
   type                      = "ingress"
   from_port                 = -1
   to_port                   = -1
   protocol                  = "icmp"
   security_group_id         = aws_security_group.sg_ping.id
   source_security_group_id  = aws_security_group.sg_8080.id
}

 resource "aws_security_group_rule" "sg_8080" {
   type                     = "ingress"
   from_port                = 8080
   to_port                  = 8080
   protocol                 = "tcp"
   security_group_id        = aws_security_group.sg_8080.id
   source_security_group_id = aws_security_group.sg_ping.id
}
