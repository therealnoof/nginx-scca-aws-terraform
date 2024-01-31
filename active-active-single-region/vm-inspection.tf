## Create Inspection device in AZ1


## Create management Network Interface for Inspection device in AZ1
resource "aws_network_interface" "management_inspection_az1" {
  subnet_id         = aws_subnet.az_1_management.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.management.id]
  tags = {
    Name = "${var.prefix}-eni_management_inspection_az1"
  }
}

## Create ingress zone Network Interface for Inspection device in AZ1
resource "aws_network_interface" "ingress_zone_inspection_az1" {
  private_ips       = ["10.0.5.206"]
  subnet_id         = aws_subnet.dmz_ingress_zone_az1.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.inspection_zone.id]
  tags = {
    Name = "${var.prefix}-eni_ingress_zone_inspection_az1"
  }
}

## Create manageent Network Interface for Inspection device in AZ1
resource "aws_network_interface" "egress_zone_inspection_az1" {
  private_ips       = ["10.0.7.219"]
  subnet_id         = aws_subnet.dmz_egress_zone_az1.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.inspection_zone.id]
  tags = {
    Name = "${var.prefix}-eni_egress_zone_inspection_az1"
  }
}




## Create Inspection device in AZ1
resource "aws_instance" "inspection_device_az1" {

  ami               = var.inspection_ami
  instance_type     = "t3.small"
  key_name          = aws_key_pair.my_keypair.key_name
  availability_zone = var.az_1
  depends_on        = [aws_internet_gateway.nginx-scca]
  user_data         = <<-EOF
  #!/bin/bash
  sudo sysctl -w net.ipv4.ip_forward=1
  EOF

  tags = {
    Name = "${var.prefix}-nginx-scca-inspection-az1"
  }
  network_interface {
    network_interface_id = aws_network_interface.management_inspection_az1.id
    device_index         = 0
  }
  network_interface {
    network_interface_id = aws_network_interface.ingress_zone_inspection_az1.id
    device_index         = 1
  }
  network_interface {
    network_interface_id = aws_network_interface.egress_zone_inspection_az1.id
    device_index         = 2
  }
}


### Create Inspection device in AZ2

## Create management Network Interface for Inspection device in AZ2
resource "aws_network_interface" "management_inspection_az2" {
  subnet_id         = aws_subnet.az_2_management.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.management.id]
  tags = {
    Name = "${var.prefix}-eni_management_inspection_az2"
  }
}

## Create ingress zone Network Interface for Inspection device in AZ2
resource "aws_network_interface" "ingress_zone_inspection_az2" {
  private_ips       = ["10.0.6.158"]
  subnet_id         = aws_subnet.dmz_ingress_zone_az2.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.inspection_zone.id]
  tags = {
    Name = "${var.prefix}-eni_ingress_zone_inspection_az2"
  }
}

## Create manageent Network Interface for Inspection device in AZ2
resource "aws_network_interface" "egress_zone_inspection_az2" {
  private_ips       = ["10.0.8.228"]
  subnet_id         = aws_subnet.dmz_egress_zone_az2.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.inspection_zone.id]
  tags = {
    Name = "${var.prefix}-eni_egress_zone_inspection_az2"
  }
}





resource "aws_instance" "inspection_device_az2" {

  ami               = var.inspection_ami
  instance_type     = "t3.small"
  key_name          = aws_key_pair.my_keypair.key_name
  availability_zone = var.az_2
  depends_on        = [aws_internet_gateway.nginx-scca]
  user_data         = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo sysctl -w net.ipv4.ip_forward=1
  EOF

  tags = {
    Name = "${var.prefix}-nginx-scca-inspection-az2"
  }
  network_interface {
    network_interface_id = aws_network_interface.management_inspection_az2.id
    device_index         = 0
  }
  network_interface {
    network_interface_id = aws_network_interface.ingress_zone_inspection_az2.id
    device_index         = 1
  }
  network_interface {
    network_interface_id = aws_network_interface.egress_zone_inspection_az2.id
    device_index         = 2
  }
}