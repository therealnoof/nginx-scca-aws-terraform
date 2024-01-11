## Create the IGW
resource "aws_internet_gateway" "nginx-scca" {
  vpc_id = aws_vpc.securitystack.id
  tags = {
    Name = "${var.prefix}-igw_nginx-scca"
  }
}


## Create the Route Table for 'management' and 'external' subnets
resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.securitystack.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.nginx-scca.id
  }

  tags = {
    Name = "${var.prefix}-rt_internet"
  }
}


# Create the Main Nginx SCCA Security Stack Route Table association
#resource "aws_main_route_table_association" "main" {
#  vpc_id         = aws_vpc.securitystack.id
#  route_table_id = aws_route_table.internet.id
#}

## Create the Route Table Associations
resource "aws_route_table_association" "az_1_management" {
  subnet_id      = aws_subnet.az_1_management.id
  route_table_id = aws_route_table.internet.id
}

resource "aws_route_table_association" "az_2_management" {
  subnet_id      = aws_subnet.az_2_management.id
  route_table_id = aws_route_table.internet.id
}

resource "aws_route_table_association" "az_1_external" {
  subnet_id      = aws_subnet.az_1_external.id
  route_table_id = aws_route_table.internet.id
}

resource "aws_route_table_association" "az_2_external" {
  subnet_id      = aws_subnet.az_2_external.id
  route_table_id = aws_route_table.internet.id
}


## Create the Route Table for 'dmz ingress zone az1' subnet
resource "aws_route_table" "ingress_zone_az1" {
  vpc_id = aws_vpc.securitystack.id
  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.nginx_ingress_zone_dmz_az1.id
  }
  route {
    cidr_block           = var.vpc_cidrs["external_az1"]
    network_interface_id = aws_network_interface.ingress_zone_inspection_az1.id
  }
  tags = {
    Name = "${var.prefix}-rt_inspection_zone_ingress_dmz_az1"
  }
}

## Create the Route Table Association
resource "aws_route_table_association" "ingress_zone_az1" {
  subnet_id      = aws_subnet.dmz_ingress_zone_az1.id
  route_table_id = aws_route_table.ingress_zone_az1.id
}


## Create the Route Table for 'dmz ingress zone az2' subnet
resource "aws_route_table" "ingress_zone_az2" {
  vpc_id = aws_vpc.securitystack.id
  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.nginx_ingress_zone_dmz_az2.id
  }
  route {
    cidr_block           = var.vpc_cidrs["external_az2"]
    network_interface_id = aws_network_interface.ingress_zone_inspection_az2.id
  }
  tags = {
    Name = "${var.prefix}-rt_inspection_zone_ingress_dmz_az2"
  }
}

## Create the Route Table Association
resource "aws_route_table_association" "ingress_zone_az2" {
  subnet_id      = aws_subnet.dmz_ingress_zone_az2.id
  route_table_id = aws_route_table.ingress_zone_az2.id
}


## Create the Route Table for 'dmz egress zone az1' subnet
resource "aws_route_table" "egress_zone_az1" {
  vpc_id = aws_vpc.securitystack.id
  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.nginx_egress_zone_dmz_az1.id
  }
  route {
    cidr_block           = var.vpc_cidrs["external_az1"]
    network_interface_id = aws_network_interface.egress_zone_inspection_az1.id
  }
  tags = {
    Name = "${var.prefix}-rt_inspection_zone_egress_dmz_az1"
  }
}

## Create the Route Table Association
resource "aws_route_table_association" "egress_zone_az1" {
  subnet_id      = aws_subnet.dmz_egress_zone_az1.id
  route_table_id = aws_route_table.egress_zone_az1.id
}


## Create the Route Table for 'dmz egress zone az2' subnet
resource "aws_route_table" "egress_zone_az2" {
  vpc_id = aws_vpc.securitystack.id
  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.nginx_egress_zone_dmz_az2.id
  }
  route {
    cidr_block           = var.vpc_cidrs["external_az2"]
    network_interface_id = aws_network_interface.egress_zone_inspection_az2.id
  }
  tags = {
    Name = "${var.prefix}-rt_inspection_zone_egress_dmz_az2"
  }
}

## Create the Route Table Association
resource "aws_route_table_association" "egress_zone_az2" {
  subnet_id      = aws_subnet.dmz_egress_zone_az2.id
  route_table_id = aws_route_table.egress_zone_az2.id
}


## Create the Route Table for 'internal az1' subnet
resource "aws_route_table" "internal_az1" {
  vpc_id = aws_vpc.securitystack.id
  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.nginx_internal_bottom_tier_az1.id
  }
  route {
    cidr_block         = var.vpc_cidrs["application"]
    transit_gateway_id = aws_ec2_transit_gateway.nginx-scca.id
  }
  tags = {
    Name = "${var.prefix}-rt_internal_az1"
  }
}

## Create the Route Table Association
resource "aws_route_table_association" "internal_az1" {
  subnet_id      = aws_subnet.internal_az1.id
  route_table_id = aws_route_table.internal_az1.id
}


## Create the Route Table for 'internal az2' subnet
resource "aws_route_table" "internal_az2" {
  vpc_id = aws_vpc.securitystack.id
  route {
    cidr_block           = "0.0.0.0/0"
    network_interface_id = aws_network_interface.nginx_internal_bottom_tier_az2.id
  }
  route {
    cidr_block         = var.vpc_cidrs["application"]
    transit_gateway_id = aws_ec2_transit_gateway.nginx-scca.id
  }
  tags = {
    Name = "${var.prefix}-rt_internal_az2"
  }
}

## Create the Route Table for 'application' subnet
resource "aws_route_table" "application" {
  vpc_id = aws_vpc.appstack.id
  route {
    cidr_block         = "0.0.0.0/0"
    transit_gateway_id = aws_ec2_transit_gateway.nginx-scca.id
  }

  tags = {
    Name = "${var.prefix}-rt_application"
  }
}

## Create the Route Table Association for 'application' subnet
resource "aws_route_table_association" "application" {
  subnet_id      = aws_subnet.application.id
  route_table_id = aws_route_table.application.id
}
