


resource "aws_vpc" "PMKVPC" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name= var.vpc_name
    }
  
}
resource "aws_internet_gateway" "PMKIGW" {
  vpc_id = aws_vpc.PMKVPC.id

  tags = {
    Name = "PMK Internet Gateway"
  }
}

resource "aws_route_table" "PMKPublicRT" {
  vpc_id = aws_vpc.PMKVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.PMKIGW.id
  }



  

  tags = {
    Name = "PMK Public Route Table"
  }
}

resource "aws_route_table" "PMKPrivateRT" {
  vpc_id = aws_vpc.PMKVPC.id

  



  

  tags = {
    Name = "PMK Private Route Table"
  }
}
resource "aws_subnet" "PMKPublicSubnets" {
  vpc_id = aws_vpc.PMKVPC.id
  count=length(var.public_subnets)
  availability_zone = var.public_subnets[count.index].zone
  cidr_block = var.public_subnets[count.index].cidr
  map_public_ip_on_launch = true
  tags = {
    Name=var.public_subnets[count.index].Name
  }
  
}
resource "aws_route_table_association" "PMKPublicRTAssociation" {
  count=length(var.public_subnets)
  subnet_id      = aws_subnet.PMKPublicSubnets[count.index].id
  route_table_id = aws_route_table.PMKPublicRT.id
}
resource "aws_subnet" "PMKPrivateSubnets" {
  vpc_id = aws_vpc.PMKVPC.id
  count=length(var.private_subnets)
  availability_zone = var.private_subnets[count.index].zone
  cidr_block = var.private_subnets[count.index].cidr
  tags = {
    Name=var.private_subnets[count.index].Name
  }
  
}
resource "aws_route_table_association" "PMKPrivateRTAssociation" {
  count=length(var.private_subnets)
  subnet_id      = aws_subnet.PMKPrivateSubnets[count.index].id
  route_table_id = aws_route_table.PMKPrivateRT.id
}