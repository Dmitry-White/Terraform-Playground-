resource "aws_instance" "app_server" {
  instance_type = "t3.micro"

  ami       = local.image.ami_id
  subnet_id = var.subnet_id

  tags = {
    Name = "${var.instance_name}-Server"
  }
}
