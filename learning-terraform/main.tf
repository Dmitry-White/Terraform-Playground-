resource "aws_instance" "web" {
  ami           = data.aws_ami.app_ami.id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    aws_security_group.web.id
  ]

  tags = {
    Name = "Learning Terraform"
  }
}

resource "aws_security_group" "web" {
  name        = "web"
  description = "Allow HTTP/S in. Allow everything out"

  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "web_http_in" {
  type      = "ingress"
  from_port = 80
  to_port   = 80

  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "web_https_in" {
  type      = "ingress"
  from_port = 443
  to_port   = 443

  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.web.id
}

resource "aws_security_group_rule" "web_http_in" {
  type      = "ingress"
  from_port = 0
  to_port   = 0

  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.web.id
}
