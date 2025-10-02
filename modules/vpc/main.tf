resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "public_subnets" {
vpc_id = aws_vpc.my_vpc.id
count=2
cidr_block = var.public_subnets[count.index]
availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnets" {
vpc_id = aws_vpc.my_vpc.id
count=2
cidr_block = var.private_subnets[count.index]
availability_zone = var.availability_zones[count.index % length(var.availability_zones)]
}


resource "aws_internet_gateway" "mygateway" {
  vpc_id = aws_vpc.my_vpc.id
}


resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygateway.id
  }
  
}
# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public.id
}
# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.my_vpc.id 
  
}
# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private.id
}