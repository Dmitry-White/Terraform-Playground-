# Create and bootstrap EC2
resource "aws_instance" "ec2" {
  ami                         = data.aws_ssm_parameter.linuxAmi.value
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = aws_subnet.subnet.id

  tags = {
    Name = "${terraform.workspace}-ec2"
  }
}
