## Create the Network Interface for the WebServer
resource "aws_network_interface" "webapp" {
  subnet_id         = aws_subnet.application.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.appstack.id]
  tags = {
    Name = "${var.prefix}-eni_webapp"
  }
}

## Create Test WebApp Server

resource "aws_instance" "webapp-server" {
  #depends_on        = [aws_internet_gateway.nginx-scca]
  ami               = var.webapp_ami
  instance_type     = "t3.small"
  key_name          = aws_key_pair.my_keypair.key_name
  availability_zone = var.az_1
  tags = {
    Name = "${var.prefix}-vm_webapp"
  }
  network_interface {
    network_interface_id = aws_network_interface.webapp.id
    device_index         = 0
  }
}
