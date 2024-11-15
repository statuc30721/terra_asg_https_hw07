# Retrieve the latest Amazon Linux AMI.

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]

  }
}

output "aws-ami_id" {
  value = data.aws_ami.latest-amazon-linux-image.id
}

resource "aws_launch_template" "app1_LT" {
    name_prefix = "app1_LT"
    image_id = data.aws_ami.latest-amazon-linux-image.id
    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.ASG01-sg01-servers.id]
    key_name = "linux-app1-server"

    # Install software on the Amazon EC2 Instance.


user_data = base64encode(<<-EOF
    #!/bin/bash
    # Use this for your user data (script from top to bottom)
    # install httpd (Linux 2 version)
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd

    # Get the IMDSv2 token
    TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

    # Background the curl requests
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/local-ipv4 &> /tmp/local_ipv4 &
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/placement/availability-zone &> /tmp/az &
    curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/ &> /tmp/macid &
    wait

    macid=$(cat /tmp/macid)
    local_ipv4=$(cat /tmp/local_ipv4)
    az=$(cat /tmp/az)
    vpc=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" -s http://169.254.169.254/latest/meta-data/network/interfaces/macs/$macid/vpc-id)

    echo "
    <!doctype html>
    <html lang=\"en\" class=\"h-100\">
    <head>
    <title>Details for EC2 instance</title>
    </head>
    <body>
    <div>
    <h1>AWS Instance Details</h1>
    <h1>Samurai Katana</h1>

    <br>
    # insert an image or GIF
    <img src="https://www.w3schools.com/images/w3schools_green.jpg" alt="W3Schools.com">
    <br>

    <p><b>Instance Name:</b> $(hostname -f) </p>
    <p><b>Instance Private Ip Address: </b> $local_ipv4</p>
    <p><b>Availability Zone: </b> $az</p>
    <p><b>Virtual Private Cloud (VPC):</b> $vpc</p>
    </div>
    </body>
    </html>
    " > /var/www/html/index.html

    # Clean up the temp files
    rm -f /tmp/local_ipv4 /tmp/az /tmp/macid
  EOF
  )


    tag_specifications {
        resource_type = "instance"
        tags = {
          Name = "app1_LT"
          Service = "application1"
          Owner = "Frodo"
          Planet = "Arda"     
          }
        }
    
    lifecycle {
        create_before_destroy = true
    }
}