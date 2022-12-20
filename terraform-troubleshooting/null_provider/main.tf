resource "aws_instance" "app_server" {
  ami           = var.instance_ami
  subnet_id     = var.subnet_id
  instance_type = data.null_data_source.ec2_values.inputs["ec2_instance_type"]

  tags = {
    Name = var.instance_name
  }
}

# The "null_resource" resource implements the standard resource lifecycle
# but takes no further action.
# The "triggers" argument allows specifying an arbitrary set of values
# that, when changed, will cause the resource to be replaced.
# Essentially, it's a dependency list similar to "useEffect" hook's dependencies in React.js.
resource "null_resource" "ec2_status" {
  provisioner "local-exec" {
    command = "./scripts/health.sh"
  }
}
