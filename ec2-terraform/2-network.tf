resource "aws_vpc" "lab_vpc" {
  cidr_block           = "10.88.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = "lab"
  }
}

resource "aws_subnet" "lab_net" {
  vpc_id                  = aws_vpc.lab_vpc.id
  cidr_block              = "10.88.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    name = "lab"
  }
}

resource "aws_internet_gateway" "lab_gw" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    name = "lab"
  }
}

resource "aws_route_table" "lab_rt" {
  vpc_id = aws_vpc.lab_vpc.id

  tags = {
    name = "lab"
  }

}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.lab_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.lab_gw.id
}

resource "aws_route_table_association" "lab_rta" {
  subnet_id      = aws_subnet.lab_net.id
  route_table_id = aws_route_table.lab_rt.id
}


resource "aws_security_group" "lab_sg" {
  name        = "lab_sg"
  description = "lab security group"
  vpc_id      = aws_vpc.lab_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
