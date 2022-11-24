resource "aws_vpc" "demo" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "demo-vpc"
  }
}
resource "aws_subnet" "pub" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "public"
  }
}
resource "aws_subnet" "pri" {
  vpc_id     = aws_vpc.demo.id
  cidr_block = "192.168.3.0/24"

  tags = {
    Name = "private"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo.id

  tags = {
    Name = "igw"
  }
}

resource "aws_eip" "ip" {
  vpc      = true
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ip.id
  subnet_id     = aws_subnet.pri.id

  tags = {
    Name = "NGW"
  }
}
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.1.0/24"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
  Name = "custom"
}
}

resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.demo.id

  route {
    cidr_block = "0.0.1.0/24"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
  Name = "demo"
}
}

resource "aws_route_table_association" "as1" {
  subnet_id      = aws_subnet.pub.id
  route_table_id = aws_route_table.rt1.id
}

resource "aws_route_table_association" "as2" {
  subnet_id      = aws_subnet.pri.id
  route_table_id = aws_route_table.rt2.id
}

resource "aws_security_group" "sg" {
  name        = "sgtest"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.demo.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.demo.cidr_block]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

 }
## this is holiday code 
