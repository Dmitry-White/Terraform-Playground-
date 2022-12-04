# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_range
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "Terraform-VPC"
  }
}

# Create IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "Terraform-IGW"
  }
}

# Create default route table
resource "aws_default_route_table" "internet_route" {
  default_route_table_id = data.aws_route_table.main_route_table.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  
  tags = {
    Name = "Terraform-RouteTable"
  }
}

# Create subnet #1
resource "aws_subnet" "subnet" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.subnet_range
  
  tags = {
    Name = "Terraform-Subnet1"
  }
}


# Create SG for allowing TCP/80 & TCP/22
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

