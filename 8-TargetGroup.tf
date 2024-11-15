resource "aws_lb_target_group" "ASG01_TG01" {
  name     = "ASG01-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.ASG01-VPC.id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name    = "ASG01-TG01"
    Service = "ASG01"
    Owner   = "Frodo"
    Project = "Web Service"
  }
}
