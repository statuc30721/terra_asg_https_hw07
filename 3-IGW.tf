resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.ASG01-VPC.id

  tags = {
    Name    = "ASG01_IGW"
    Service = "application1"
    Owner   = "Frodo"
    Planet  = "Arda"
  }
}
