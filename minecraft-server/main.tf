resource "aws_key_pair" "server_key" {
  key_name   = local.server.public_ssh_key
  public_key = file(var.public_key_path)

  tags = {
    Name  = local.server.public_ssh_key
    Scope = local.scope
  }
}

resource "aws_instance" "server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.server_key.key_name
  vpc_security_group_ids = [aws_security_group.server_sg.id]

  iam_instance_profile = aws_iam_instance_profile.server_profile.name

  user_data = data.cloudinit_config.server_config.rendered

  metadata_options {
    instance_metadata_tags = "enabled"
  }

  tags = {
    Name  = local.server.name
    Scope = local.scope
  }
}
