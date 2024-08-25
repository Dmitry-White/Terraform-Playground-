resource "aws_key_pair" "server_key" {
  key_name   = local.ssh_key
  public_key = file(var.ssh_key_path)
}

resource "aws_instance" "server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.server_key.key_name
  vpc_security_group_ids = [aws_security_group.server_sg.id]

  user_data = data.cloudinit_config.server_config.rendered

  metadata_options {
    instance_metadata_tags = "enabled"
  }

  tags = {
    Name = local.server_name
  }
}
