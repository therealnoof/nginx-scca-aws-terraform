#
# Deploy Nginx+
#

## Create network interfaces

## Create Management Network Interface for Nginx+ top tier in AZ1
resource "aws_network_interface" "nginx_management_top_tier_az1" {
  subnet_id         = aws_subnet.az_1_management.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.management.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_management_top_tier_az1"
  }
}

## Create Management Network Interface for Nginx+ top tier in AZ2
resource "aws_network_interface" "nginx_management_top_tier_az2" {
  subnet_id         = aws_subnet.az_2_management.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.management.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_management_top_tier_az2"
  }
}

## Create Management Network Interface for Nginx+ bottom tier in AZ1
resource "aws_network_interface" "nginx_management_bottom_tier_az1" {
  subnet_id         = aws_subnet.az_1_management.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.management.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_management_bottom_tier_az1"
  }
}

## Create Management Network Interface for Nginx+ bottom tier in AZ2
resource "aws_network_interface" "nginx_management_bottom_tier_az2" {
  subnet_id         = aws_subnet.az_2_management.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.management.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_management_bottom_tier_az2"
  }
}

## Create External Network Interface for Nginx+ top tier in AZ1
resource "aws_network_interface" "nginx_external_top_tier_az1" {
  subnet_id         = aws_subnet.az_1_external.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.external.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_external_top_tier_az1"
  }
}

## Create External Network Interface for Nginx+ top tier in AZ2
resource "aws_network_interface" "nginx_external_top_tier_az2" {
  subnet_id         = aws_subnet.az_2_external.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.external.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_external_top_tier_az2"
  }
}


## Create Internal Network Interface for Nginix+ bottom tier in AZ1
resource "aws_network_interface" "nginx_internal_bottom_tier_az1" {
  subnet_id         = aws_subnet.internal_az1.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.internal.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_internal_bottom_tier_az1"
  }
}

## Create Internal Network Interface for Nginix+ bottom tier in AZ2
resource "aws_network_interface" "nginx_internal_bottom_tier_az2" {
  subnet_id         = aws_subnet.internal_az2.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.internal.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_internal_bottom_tier_az2"
  }
}

## Create dmz ingress zone Network Interface for Nginx+ in AZ1
resource "aws_network_interface" "nginx_ingress_zone_dmz_az1" {
  subnet_id         = aws_subnet.dmz_ingress_zone_az1.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.inspection_zone.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_dmz_ingress_zone_az1"
  }
}

## Create dmz ingress zone Network Interface for Nginx+ in AZ2
resource "aws_network_interface" "nginx_ingress_zone_dmz_az2" {
  subnet_id         = aws_subnet.dmz_ingress_zone_az2.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.inspection_zone.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_dmz_ingress_zone_az2"
  }
}

## Create dmz egress zone Network Interface for Nginx+ in AZ1
resource "aws_network_interface" "nginx_egress_zone_dmz_az1" {
  subnet_id         = aws_subnet.dmz_egress_zone_az1.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.inspection_zone.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_dmz_egress_zone_az1"
  }
}

## Create dmz egress zone Network Interface for Nginx+ in AZ2
resource "aws_network_interface" "nginx_egress_zone_dmz_az2" {
  subnet_id         = aws_subnet.dmz_egress_zone_az2.id
  source_dest_check = "false"
  security_groups   = [aws_security_group.inspection_zone.id]
  tags = {
    Name = "${var.prefix}-eni_nginx_dmz_egress_zone_az2"
  }
}



# 
# Nginx+
#


## Create Nginx+ top tier az1

# create the mapping to the config file to bootstrap the tier 1 az1 nginx instance
data "template_file" "nginx_tier1_az1" {
  template = file("nginx_tier1_az1.tpl")
}

resource "aws_instance" "nginx_top_az1" {
  depends_on        = [aws_route_table_association.az_1_management]
  ami               = var.nginx_ami
  instance_type     = var.instance_type
  key_name          = aws_key_pair.my_keypair.key_name
  user_data         = data.template_file.nginx_tier1_az1.rendered
  availability_zone = var.az_1
  


  tags = {
    Name = "${var.prefix}-vm_nginx_top_az1"
  }
  # set the mgmt interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_management_top_tier_az1.id
    device_index         = 0
  }
  # set the external interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_external_top_tier_az1.id
    device_index         = 1
  }
  # set the ingress zone interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_ingress_zone_dmz_az1.id
    device_index         = 2
  }
}


## Create Nginx+ top tier az2

# create the mapping to the config file to bootstrap the tier 1 az2 nginx instance
data "template_file" "nginx_tier1_az2" {
  template = file("nginx_tier1_az2.tpl")
}

resource "aws_instance" "nginx_top_az2" {
  depends_on        = [aws_route_table_association.az_2_management]
  ami               = var.nginx_ami
  instance_type     = var.instance_type
  key_name          = aws_key_pair.my_keypair.key_name
  user_data         = data.template_file.nginx_tier1_az2.rendered
  availability_zone = var.az_2


  tags = {
    Name = "${var.prefix}-vm_nginx_top_az2"
  }
  # set the mgmt interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_management_top_tier_az2.id
    device_index         = 0
  }
  # set the external interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_external_top_tier_az2.id
    device_index         = 1
  }
  # set the ingress zone interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_ingress_zone_dmz_az2.id
    device_index         = 2
  }
}

## Create Nginx+ bottom tier az1
resource "aws_instance" "nginx_bottom_az1" {
  depends_on        = [aws_route_table_association.az_1_management]
  ami               = var.nginx_ami
  instance_type     = var.instance_type
  key_name          = aws_key_pair.my_keypair.key_name
  availability_zone = var.az_1


  tags = {
    Name = "${var.prefix}-vm_nginx_bottom_az1"
  }
  # set the mgmt interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_management_bottom_tier_az1.id
    device_index         = 0
  }
  # set the egress zone interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_egress_zone_dmz_az1.id
    device_index         = 1
  }
  # set the internal bottom tier interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_internal_bottom_tier_az1.id
    device_index         = 2
  }
}


## Create Nginx+ bottom tier az2
resource "aws_instance" "nginx_bottom_az2" {
  depends_on        = [aws_route_table_association.az_2_management]
  ami               = var.nginx_ami
  instance_type     = var.instance_type
  key_name          = aws_key_pair.my_keypair.key_name
  availability_zone = var.az_2


  tags = {
    Name = "${var.prefix}-vm_nginx_bottom_az2"
  }
  # set the mgmt interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_management_bottom_tier_az2.id
    device_index         = 0
  }
  # set the egress zone interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_egress_zone_dmz_az2.id
    device_index         = 1
  }
  # set the internal bottom tier interface 
  network_interface {
    network_interface_id = aws_network_interface.nginx_internal_bottom_tier_az2.id
    device_index         = 2
  }
}