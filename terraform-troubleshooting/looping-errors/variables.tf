variable "region" {
  description = "The AWS region your resources will be deployed"
}

variable "name" {
  description = "The operator name running this configuration"
}


locals {
  network = {
    full_cidr   = "10.0.0.0/16"
    subnet_cidr = "10.0.1.0/24"
  }
  image = {
    ami_id = "ami-076309742d466ad69"
  }
}