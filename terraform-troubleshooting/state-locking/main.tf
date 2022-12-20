resource "aws_instance" "web_app" {
  for_each = local.security_groups

  instance_type = "t3.micro"

  ami                    = local.image.ami_id
  subnet_id              = local.network.subnet_id
  vpc_security_group_ids = [each.value]

  user_data = file("./scripts/user-data.sh")

  tags = {
    Name = var.instance_name
  }
}
