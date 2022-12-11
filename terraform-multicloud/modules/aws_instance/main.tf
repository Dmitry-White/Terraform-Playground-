resource "aws_key_pair" "webserver-key" {
  key_name   = "webserver-key"
  public_key = file(local.creds.ssh_key_path)
}

resource "aws_instance" "instance" {
  count = var.instance_count

  instance_type = var.instance_type

  key_name                    = aws_key_pair.webserver-key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id

  ami = local.image.ami_id

  tags = {
    Name = "intance-${count.index}"
  }
}
