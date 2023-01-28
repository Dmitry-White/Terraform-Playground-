# //////////////////////////////
# REQUIRED
# //////////////////////////////
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "ssh_key_name" {}

variable "private_key_path" {}

# //////////////////////////////
# OPTIONAL
# //////////////////////////////
variable "deploy_environment" {
  default = "DEV"
}

variable "region" {
  default = "us-east-2"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "environment_list" {
  type    = list(string)
  default = ["DEV", "QA", "STAGE", "PROD"]
}

variable "environment_map" {
  type = map(string)
  default = {
    "DEV"   = "DEV",
    "QA"    = "QA",
    "STAGE" = "STAGE",
    "PROD"  = "PROD"
  }
}

variable "environment_instance_type" {
  type = map(string)
  default = {
    "DEV"   = "t2.micro",
    "QA"    = "t2.micro",
    "STAGE" = "t2.micro",
    "PROD"  = "t2.micro"
  }
}

variable "environment_instance_settings" {
  type = map(object({ instance_type = string, monitoring = bool }))
  default = {
    "DEV" = {
      instance_type = "t2.micro",
      monitoring    = false
    },
    "QA" = {
      instance_type = "t2.micro",
      monitoring    = false
    },
    "STAGE" = {
      instance_type = "t2.micro",
      monitoring    = false
    },
    "PROD" = {
      instance_type = "t2.micro",
      monitoring    = true
    }
  }
}

# //////////////////////////////
# DATA
# //////////////////////////////
data "aws_availability_zones" "available" {}

data "aws_ami" "aws-linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
