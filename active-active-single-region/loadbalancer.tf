# Create a NLB in AWS for the purpose of load balancing traffic across a pair of Nginx instances

resource "aws_lb" "nlb" {
  name               = "nginx-scca-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = [aws_subnet.az_1_external.id,aws_subnet.az_2_external.id]
  security_groups    = [aws_security_group.external.id]
  # customer_owned_ipv4_pool = "name of private pool" 
  # use this option for BYOIP in Gov environments- see Hashicorp documentation
  enable_cross_zone_load_balancing = true
  enable_deletion_protection       = false

  tags = {
    Name       = "${var.prefix}-nlb"
    Group_Name = "${var.prefix}-nlb"
  }
}

# Create the Listeners

resource "aws_lb_listener" "security_stack_443" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "443"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_stack_443.arn
  }
}

resource "aws_lb_listener" "security_stack_80" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = "80"
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_stack_80.arn
  }
}


# Create the Target Groups

resource "aws_lb_target_group" "nginx_stack_80" {
  name               = "nginx-stack-80"
  preserve_client_ip = "true"
  port               = 80
  protocol           = "TCP"
  target_type        = "ip"
  vpc_id             = aws_vpc.securitystack.id

  stickiness {
    type = "source_ip"
  }

  health_check {
    interval            = 30
    port                = 80
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "nginx_stack_443" {
  name               = "nginx-stack-443"
  preserve_client_ip = "true"
  port               = 443
  protocol           = "TCP"
  target_type        = "ip"
  vpc_id             = aws_vpc.securitystack.id

  stickiness {
    type = "source_ip"
  }

  health_check {
    interval            = 30
    port                = 443
    protocol            = "TCP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "nginx_stack_80_az1" {
  target_group_arn = aws_lb_target_group.nginx_stack_80.arn
  target_id        = "aws_network_interface.nginx_external_top_tier_az1.id"
  port             = 80
}

resource "aws_lb_target_group_attachment" "nginx_stack_80_az2" {
  target_group_arn = aws_lb_target_group.nginx_stack_80.arn
  target_id        = "aws_network_interface.nginx_external_top_tier_az2.id"
  port             = 80
}

resource "aws_lb_target_group_attachment" "nginx_stack_443_az1" {
  target_group_arn = aws_lb_target_group.nginx_stack_443.arn
  target_id        = "aws_network_interface.nginx_external_top_tier_az1.id"
  port             = 443
}

resource "aws_lb_target_group_attachment" "nginx_stack_443_az2" {
  target_group_arn = aws_lb_target_group.nginx_stack_443.arn
  target_id        = "aws_network_interface.nginx_external_top_tier_az2.id"
  port             = 443
}

