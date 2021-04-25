resource "aws_security_group" "WPLoadBalancerSG" {
  vpc_id = aws_vpc.Wordpress-workshop.id
  name   = var.sg_load_balancer

  ingress {
    description = "HTTP rule"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    #security_groups = [aws_security_group.WPFSClientSG.id]
  }

  egress {

    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

    #security_groups = [aws_security_group.WPFSClientSG.id]
  }

  tags = {
    Name = "WP Load Balancer SG"
  }
}

resource "aws_lb" "lb" {

  name               = var.loadbalancer_name
  internal           = false
  load_balancer_type = var.loadbalancer_type
  security_groups    = [aws_security_group.WPLoadBalancerSG.id]
  subnets            = [aws_subnet.Public-Subnets[0].id, aws_subnet.Public-Subnets[1].id]

  tags = {
    Name = "Wordpress LB"
  }
}

resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = var.http_port
  protocol          = var.http_protocol

  default_action {
    type             = var.default_action_type
    target_group_arn = aws_lb_target_group.lb-target-group.arn
  }
}

resource "aws_lb_target_group" "lb-target-group" {
  name     = var.lb_target_group_name
  port     = var.http_port
  protocol = var.http_protocol
  vpc_id   = aws_vpc.Wordpress-workshop.id
  tags = {
    "Name" = "Target Group WP"
  }
}
