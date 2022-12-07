module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "Terraform-VPC"
  cidr = "10.0.0.0/16"

  azs            = ["us-east-1a"]
  public_subnets = ["10.0.1.0/24"]
}


resource "aws_security_group" "sg" {
  name   = join("_", ["sg", module.vpc.vpc_id])
  vpc_id = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = var.rules
    content {
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["proto"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform-Dynamic-SG"
  }
}

resource "aws_instance" "webserver" {
  ami             = data.aws_ssm_parameter.ami_id.value
  instance_type   = "t3.micro"

  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.sg.id]

  user_data = fileexists("script.sh") ? file("script.sh") : null
}
