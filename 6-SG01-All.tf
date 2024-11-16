# Security group for Production Application Servers. 
resource "aws_security_group" "ASG01-sg01-servers" {
    name = "ASG01-sg01-servers"
    description = "Allow SSH and HTTP traffic to production servers"
    vpc_id = aws_vpc.ASG01-VPC.id

    ingress {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
        Name = "ASG01-sg01-servers"
        Service = "application1"
        Owner = "Frodo"
        Planet = "Arda"
    }
}


# Security Group for Load Balancer. 

resource "aws_security_group" "ASG01-sg02-LB01" {
    name = "ASG01-sg02-LB01"
    description = "Allow HTTP inbound traffic to Load Balancer."
    vpc_id = aws_vpc.ASG01-VPC.id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


  ingress {
        description = "HTTPS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
        Name = "ASG01-sg02-LB01"
        Service = "application1"
        Owner = "Frodo"
        Planet = "Arda"
    }
}

resource "aws_security_group" "ASG01-sg03-443" {
    name = "ASG01-sg03-443"
    description = "Allow HTTPS traffic to production servers"
    vpc_id = aws_vpc.ASG01-VPC.id

        ingress {
        description = "HTTS"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
        Name = "ASG01-sg03-443"
        Service = "application1"
        Owner = "Frodo"
        Planet = "Arda"
    }
}
