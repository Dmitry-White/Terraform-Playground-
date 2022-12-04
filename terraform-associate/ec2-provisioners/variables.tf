# Provide a way to override the default SSH key path
variable "ssh_key_path" {
  type = string
  description = "SSH Key Path"
  default     = "~/.ssh/id_rsa.pub"
}

# Provide a way to override the default CIDR block
variable "vpc_range" {
  type = string
  description = "VPC IP Range"
  default     = "10.0.0.0/16"
}

# Provide a way to override the default Subnet range
variable "subnet_range" {
  type = string
  description = "Subnet IP Range"
  default     = "10.0.1.0/24"
}

# Get Linux AMI ID using SSM Parameter endpoint
data "aws_ssm_parameter" "webserver-ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# Get main route table to modify
data "aws_route_table" "main_route_table" {
  filter {
    name   = "association.main"
    values = ["true"]
  }
  filter {
    name   = "vpc-id"
    values = [aws_vpc.vpc.id]
  }
}

# Get all available AZ's in the VPC
data "aws_availability_zones" "azs" {
  state = "available"
}
