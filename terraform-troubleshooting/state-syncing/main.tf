resource "aws_instance" "web_app" {
  instance_type = "t3.micro"

  ami       = data.aws_ami.amazon_linux.id
  subnet_id = local.network.subnet_id

  tags = {
    Name = var.instance_name
  }
}
