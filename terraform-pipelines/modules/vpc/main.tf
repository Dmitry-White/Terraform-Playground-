resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_range

  tags = {
    Name = "Terraform-VPC"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.subnet_range

  tags = {
    Name = "Terraform-Subnet1"
  }
}
