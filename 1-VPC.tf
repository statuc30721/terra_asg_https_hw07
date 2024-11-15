# this  makes  vpc.id which is aws_vpc.ASG01-VPC.id
resource "aws_vpc" "ASG01-VPC" {
  cidr_block = "10.22.0.0/16"

  tags = {
    Name = "ASG01-VPC"
    Service = "application1"
    Owner = "Frodo"
    Planet = "Arda"
  }
}