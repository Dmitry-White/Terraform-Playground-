resource "aws_instance" "instance" {
  count = var.instance_count

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet

  tags = {
    Name = "intance-${count.index}"
  }
}