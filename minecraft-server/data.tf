data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [local.image_owner]

  filter {
    name   = "name"
    values = [local.image_filter_name]
  }

  filter {
    name   = "virtualization-type"
    values = [local.image_filter_type]
  }
}

data "cloudinit_config" "server_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    filename     = local.user_data_file
    content = templatefile(local.user_data_file, {
      tf_node_user = local.node_user
      tf_home_path = local.home_path
    })
  }
}
