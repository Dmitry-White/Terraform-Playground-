# //////////////////////////////
# VARIABLES
# //////////////////////////////
variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "ssh_key_name" {}

variable "private_key_path" {}

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
# PROVIDERS
# //////////////////////////////
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.region
}

# //////////////////////////////
# MODULES
# //////////////////////////////
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "frontend-vpc"
  cidr   = var.vpc_cidr

  azs             = ["us-east-2a", "us-east-2b", "us-east-2c"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
  # one_nat_gateway_per_az = true
}

# //////////////////////////////
# RESOURCES
# //////////////////////////////

# SECURITY_GROUP
resource "aws_security_group" "sg-nodejs-instance" {
  name   = "nodejs_sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# INSTANCE
resource "aws_instance" "nodejs1" {
  ami           = data.aws_ami.aws-linux.id
  instance_type = var.environment_instance_type[var.deploy_environment]
  //instance_type = var.environment_instance_settings["PROD"].instance_type
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.sg-nodejs-instance.id]
  key_name               = var.ssh_key_name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  monitoring = var.environment_instance_settings[var.deploy_environment].monitoring

  tags = {
    Environment = var.environment_list[0]
    Deployment  = var.environment_map[var.deploy_environment]
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

# //////////////////////////////
# OUTPUT
# //////////////////////////////
output "instance-dns" {
  value = aws_instance.nodejs1.public_dns
}

output "private-dns" {
  value = aws_instance.nodejs1.private_dns
}
