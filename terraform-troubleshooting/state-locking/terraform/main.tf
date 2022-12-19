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
  for_each               = local.security_groups
  ami                    = "ami-0fe472d8a85bc7b0e"
  subnet_id              = "subnet-0541e9d576c6be3cb"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [each.value]
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
  tags = {
    Name = "${var.name}-justice-$[each.value]"
  }
}

resource "aws_security_group" "sg_ping" {
  name   = "Allow Ping"
  vpc_id = "vpc-00a2894b9881388aa"
}

resource "aws_security_group" "sg_8080" {
  name   = "Allow 8080"
  vpc_id = "vpc-00a2894b9881388aa"
}

resource "aws_security_group_rule" "sg_ping" {
  type                     = "ingress"
  from_port                = -1
  to_port                  = -1
  protocol                 = "icmp"
  security_group_id        = aws_security_group.sg_ping.id
  source_security_group_id = aws_security_group.sg_8080.id
}

resource "aws_security_group_rule" "sg_8080" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.sg_8080.id
  source_security_group_id = aws_security_group.sg_ping.id
}

locals {
  security_groups = {
    sg_ping = aws_security_group.sg_ping.id,
    sg_8080 = aws_security_group.sg_8080.id,
  }
}
