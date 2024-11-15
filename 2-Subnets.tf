# These are for the public subnets.

# Note: There is only ONE VPC in this architecture.

resource "aws_subnet" "public-us-east-1a" {
  vpc_id                  = aws_vpc.ASG01-VPC.id
  cidr_block              = "10.22.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1a"
    Service = "application1"
    Owner   = "Frodo"
    Planet  = "Arda"
  }
}

resource "aws_subnet" "public-us-east-1b" {
  vpc_id                  = aws_vpc.ASG01-VPC.id
  cidr_block              = "10.22.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1b"
    Service = "application1"
    Owner   = "Frodo"
    Planet  = "Arda"
  }
}

resource "aws_subnet" "public-us-east-1c" {
  vpc_id                  = aws_vpc.ASG01-VPC.id
  cidr_block              = "10.22.3.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-us-east-1c"
    Service = "application1"
    Owner   = "Frodo"
    Planet  = "Arda"
  }
}



# These are for the private subnets.

resource "aws_subnet" "private-us-east-1a" {
  vpc_id            = aws_vpc.ASG01-VPC.id
  cidr_block        = "10.22.11.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name    = "private-us-east-1a"
    Service = "application1"
    Owner   = "Frodo"
    Planet  = "Arda"
  }
}

resource "aws_subnet" "private-us-east-1b" {
  vpc_id            = aws_vpc.ASG01-VPC.id
  cidr_block        = "10.22.12.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name    = "private-us-east-1b"
    Service = "application1"
    Owner   = "Frodo"
    Planet  = "Arda"
  }
}


resource "aws_subnet" "private-us-east-1c" {
  vpc_id            = aws_vpc.ASG01-VPC.id
  cidr_block        = "10.22.13.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name    = "private-us-east-1c"
    Service = "application1"
    Owner   = "Frodo"
    Planet  = "Arda"
  }
}
