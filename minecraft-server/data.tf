data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = [local.image_filter.owner]

  filter {
    name   = "name"
    values = [local.image_filter.name]
  }

  filter {
    name   = "virtualization-type"
    values = [local.image_filter.type]
  }
}

data "cloudinit_config" "server_config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    filename     = local.user_data_file
    content = templatefile(local.user_data_file, {
      tf_server_bucket             = var.server_bucket,
      tf_server_bucket_game_folder = var.server_bucket_game_folder,
      tf_server_ram                = local.server.memory,
    })
  }
}

data "aws_iam_policy_document" "server_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
