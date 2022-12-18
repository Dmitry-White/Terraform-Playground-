variable "region" {
  description = "The AWS region your resources will be deployed"
}

variable "name" {
  description = "The operator name running this configuration"
}

locals {
  network = {
    vpc_id    = "<VPC_ID>"
    subnet_id = "<SUBNET_ID>"
  }
  image = {
    ami_id = "<DUMMY_AMI>"
  }
  security_groups = {
    sg_ping = aws_security_group.sg_ping.id,
    sg_8080 = aws_security_group.sg_8080.id,
  }
}
