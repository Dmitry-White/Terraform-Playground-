resource "aws_instance" "app_server" {
  ami           = "DUMMY_VALUE_AMI"
  instance_type = "t3.micro"
  subnet_id     = "<DUMMY_VALUE_SUBNET_ID>"
  tags = {
    Name = "WayneCorp"
  }
}