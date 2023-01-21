variable "instance_type" {
  description = "Type of EC2 instance to provision"
  default     = "t3.nano"
}

variable "ami_filter" {
  description = "Name filter, type and owner for AMI"
  type = object({
    name  = string
    type  = string
    owner = string
  })
  default = {
    name  = "bitnami-tomcat-*-x86_64-hvm-ebs-nami"
    type  = "hvm"
    owner = "979382823631" # Bitnami
  }
}

variable "region" {
  description = "Region to deploy to"
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment to deploy to"
  type = object({
    name           = string
    network_prefix = string
  })
  default = {
    name           = "dev"
    network_prefix = "10.0"
  }
}

variable "asg_size" {
  description = "Autoscaling group min and max sizes"
  type = object({
    min = string
    max = string
  })
  default = {
    min = 1
    max = 2
  }
}

data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ami_filter.name]
  }

  filter {
    name   = "virtualization-type"
    values = [var.ami_filter.type]
  }

  owners = [var.ami_filter.owner] # Bitnami
}
