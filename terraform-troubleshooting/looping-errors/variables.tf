variable "region" {
  type        = string
  description = "The AWS region your resources will be deployed"
}

variable "name" {
  type        = string
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
}
