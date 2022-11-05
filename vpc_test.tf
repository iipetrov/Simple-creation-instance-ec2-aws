resource "aws_vpc" "vpc_test" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc_test"
  }
}

resource "aws_subnet" "subnet1"{
  vpc_id = aws_vpc.vpc_test.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_internet_gateway" "gtw_gateway" {
  vpc_id = aws_vpc.vpc_test.id

  tags = {
    Name = "my_gtw"
  }
}

resource "aws_route_table" "rt_route_table" {
  vpc_id = aws_vpc.vpc_test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gtw_gateway.id
  }
  tags = {
    Name = "routing_table"
  }
}
  
  resource "aws_route_table_association" "routing_association" {
    subnet_id      = aws_subnet.subnet1.id
    route_table_id = aws_route_table.rt_route_table.id
  }