variable "region" {
  type        = string
  description = "The AWS region your resources will be deployed"
  default     = "us-east-1"
}

variable "instance_name" {
  type        = string
  description = "The operator name running this configuration"
  default     = "Terraform-Instance"
}

data "aws_ami" "amazon_linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = [locals.image.ami_name]
  }
}

locals {
  image = {
    ami_name = "<DUMMY_AMI>"
  }
  network = {
    vpc_id    = "<VPC_ID>"
    subnet_id = "<SUBNET_ID>"
  }
}
