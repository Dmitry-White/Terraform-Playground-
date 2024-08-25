resource "aws_security_group" "server_sg" {
  name = local.sg_name

  dynamic "ingress" {
    for_each = local.ingress_rules

    content {
      description = "Minecraft ${ingress.value["protocol"]} ${ingress.value["port"]} from the internet"
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
