## Create Management az1 Subnet 
resource "aws_subnet" "az_1_management" {
  vpc_id            = aws_vpc.securitystack.id
  cidr_block        = var.vpc_cidrs["management_az1"]
  availability_zone = var.az_1
  tags = {
    Name       = "${var.prefix}-az_1_subnet_management"
    Group_Name = "${var.prefix}-az_1_subnet_management"
  }
}

## Create Management az2 Subnet 
resource "aws_subnet" "az_2_management" {
  vpc_id            = aws_vpc.securitystack.id
  cidr_block        = var.vpc_cidrs["management_az2"]
  availability_zone = var.az_2
  tags = {
    Name       = "${var.prefix}-az_2_subnet_management"
    Group_Name = "${var.prefix}-az_2_subnet_management"
  }
}


## Create External az1 Subnet
resource "aws_subnet" "az_1_external" {
  vpc_id            = aws_vpc.securitystack.id
  cidr_block        = var.vpc_cidrs["external_az1"]
  availability_zone = var.az_1
  tags = {
    Name       = "${var.prefix}-az_1_subnet_external"
    Group_Name = "${var.prefix}-az_1_subnet_external"
  }
}

# Create External az2 Subnet
resource "aws_subnet" "az_2_external" {
  vpc_id            = aws_vpc.securitystack.id
  cidr_block        = var.vpc_cidrs["external_az2"]
  availability_zone = var.az_2
  tags = {
    Name       = "${var.prefix}-az_2_subnet_external"
    Group_Name = "${var.prefix}-az_2_subnet_external"
  }
}


## Create DMZ Ingress az1 Subnet
resource "aws_subnet" "dmz_ingress_az1" {
  vpc_id            = aws_vpc.securitystack.id
  cidr_block        = var.vpc_cidrs["dmz_ingress_az1"]
  availability_zone = var.az_1
  tags = {
    Name       = "${var.prefix}-subnet_dmz_ingress_az1"
    Group_Name = "${var.prefix}-subnet_dmz_ingress_az1"
  }
}

## Create DMZ Ingress az2 Subnet
resource "aws_subnet" "dmz_ingress_az2" {
  vpc_id            = aws_vpc.securitystack.id
  cidr_block        = var.vpc_cidrs["dmz_ingress_az2"]
  availability_zone = var.az_2
  tags = {
    Name       = "${var.prefix}-subnet_dmz_ingress_az2"
    Group_Name = "${var.prefix}-subnet_dmz_ingress_az2"
  }
}


## Create DMZ Egress az1 Subnet
resource "aws_subnet" "dmz_egress_az1" {
  vpc_id            = aws_vpc.securitystack.id
  cidr_block        = var.vpc_cidrs["dmz_egress_az1"]
  availability_zone = var.az_1
  tags = {
    Name       = "${var.prefix}-subnet_dmz_egress_az1"
    Group_Name = "${var.prefix}-subnet_dmz_egress_az1"
  }
}

## Create DMZ Egress az2 Subnet
resource "aws_subnet" "dmz_egress_az2" {
  vpc_id            = aws_vpc.securitystack.id
  cidr_block        = var.vpc_cidrs["dmz_egress_az2"]
  availability_zone = var.az_2
  tags = {
    Name       = "${var.prefix}-subnet_dmz_egress_az2"
    Group_Name = "${var.prefix}-subnet_dmz_egress_az2"
  }
}


## Create Internal az1 Subnet
resource "aws_subnet" "internal_az1" {
  vpc_id            = aws_vpc.securitystack.id
  cidr_block        = var.vpc_cidrs["internal_az1"]
  availability_zone = var.az_1
  tags = {
    Name       = "${var.prefix}-subnet_internal_az1"
    Group_Name = "${var.prefix}-subnet_internal_az1"
  }
}

## Create Internal az2 Subnet
resource "aws_subnet" "internal_az2" {
  vpc_id            = aws_vpc.securitystack.id
  cidr_block        = var.vpc_cidrs["internal_az2"]
  availability_zone = var.az_2
  tags = {
    Name       = "${var.prefix}-subnet_internal_az2"
    Group_Name = "${var.prefix}-subnet_internal_az2"
  }
}

## Create Application Subnet
resource "aws_subnet" "application" {
  vpc_id            = aws_vpc.appstack.id
  cidr_block        = var.vpc_cidrs["application"]
  availability_zone = var.az_1
  tags = {
    Name       = "${var.prefix}-subnet_application"
    Group_Name = "${var.prefix}-subnet_application"
  }
}
