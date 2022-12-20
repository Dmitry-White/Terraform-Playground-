resource "aws_instance" "web_app" {
  for_each = local.security_groups

  instance_type = "t3.micro"

  ami                    = local.image.ami_id
  subnet_id              = local.network.subnet_id
  vpc_security_group_ids = [each.value]

  user_data = file("./scripts/user-data.sh")

  # Intentionally incorrect
  tags = {
    Name = $var.name-justice-$each.key
  }
}

resource "aws_security_group" "sg_ping" {
  name   = "Allow Ping"
  vpc_id = "<DUMMY VALUE>"

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    security_groups = [aws_security_group.sg_8080.id]
  }
}

resource "aws_security_group" "sg_8080" {
  name   = "Allow 8080"
  vpc_id = "<DUMMY VALUE>"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_ping.id]
  }
}
