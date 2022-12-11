resource "aws_vpc" "vpc" {
  cidr_block           = local.network.full_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Terraform-VPC"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = local.network.subnet_cidr

  tags = {
    Name = "Terraform-Subnet"
  }
}

resource "aws_security_group" "sg" {
  name        = "Terraform-SG"
  description = "Allow TCP/80 & TCP/22"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow traffic from TCP/80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform-SG"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Terraform-IGW"
  }
}

resource "aws_route_table" "routes" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Terraform-RouteTable"
  }
}
