## Create the TGW
resource "aws_ec2_transit_gateway" "nginx-scca" {
  description = "Transit Gateway for Nginx SCCA"
  tags = {
    Name = "${var.prefix}-tgw_nginx_scca"
  }
}


## Create the TGW Attachments
resource "aws_ec2_transit_gateway_vpc_attachment" "securitystack" {
  subnet_ids             = [aws_subnet.internal.id]
  transit_gateway_id     = aws_ec2_transit_gateway.nginx-scca.id
  vpc_id                 = aws_vpc.securitystack.id
  appliance_mode_support = "enable"
  tags = {
    Name = "${var.prefix}-tgw_attachment_securitystack"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "appstack" {
  subnet_ids             = [aws_subnet.application.id]
  transit_gateway_id     = aws_ec2_transit_gateway.nginx-scca.id
  vpc_id                 = aws_vpc.app stack.id
  appliance_mode_support = "enable"
  tags = {
    Name = "${var.prefix}-tgw_attachment_appstack"
  }
}


## Set static route pointing to the securitystack VPC 
resource "aws_ec2_transit_gateway_route" "return_public_ip" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.securitystack.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.nginx-scca.association_default_route_table_id
}


## Create the TGW Route Table
resource "aws_ec2_transit_gateway_route_table" "nginx-scca" {
  transit_gateway_id = aws_ec2_transit_gateway.nginx-scca.id
  tags = {
    Name = "${var.prefix}-rt_tgw_nginx-scca"
  }
}
