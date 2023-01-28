resource "aws_security_group" "nodejs-sg" {
  name   = "nodejs_sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nodejs" {
  ami           = data.aws_ami.aws-linux.id
  instance_type = var.environment_instance_type[var.deploy_environment]
  //instance_type = var.environment_instance_settings["PROD"].instance_type
  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.nodejs-sg.id]
  key_name               = var.ssh_key_name

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
  }

  monitoring = var.environment_instance_settings[var.deploy_environment].monitoring

  tags = {
    Environment = var.environment_list[0]
    Deployment  = var.environment_map[var.deploy_environment]
  }

}
