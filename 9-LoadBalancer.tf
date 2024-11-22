resource "aws_lb" "ASG01-LB01" {
  name               = "ASG01-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ASG01-sg02-LB01.id]
  subnets            = [
    aws_subnet.public-us-east-1a.id,
    aws_subnet.public-us-east-1b.id,
    aws_subnet.public-us-east-1c.id
  ]
  enable_deletion_protection = false
#Lots of death and suffering here, make sure it's false

  tags = {
    Name    = "ASG01-LB01"
    Service = "App1"
    Owner   = "Frodo"
    Project = "Web Service"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.ASG01-LB01.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ASG01_TG01.arn
  }
}


#--------------------------------------------#
# HTTPS Setup


# Identify SSL certificate for domain name.
data "aws_acm_certificate" "certificate" {
  domain = "app1.devlab405.click"
  statuses = ["ISSUED"]
  most_recent = true
}

# Secondary listener for HTTPS traffic.
resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.ASG01-LB01.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn = data.aws_acm_certificate.certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ASG02_TG01.arn
  }
}


output "lb_dns_name" {
  value       = aws_lb.ASG01-LB01.dns_name
  description = "The DNS name of the App1 Load Balancer."
}