


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
  for_each = var.public_subnets
  vpc_id = aws_vpc.PMKVPC.id
  
  availability_zone = each.value.zone
  cidr_block = each.value.cidr
  map_public_ip_on_launch = true
  tags = {
    Name=each.value.Name
  }
  
}
resource "aws_route_table_association" "PMKPublicRTAssociation" {
  for_each = aws_subnet.PMKPublicSubnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.PMKPublicRT.id
}
resource "aws_subnet" "PMKPrivateSubnets" {
  for_each = var.private_subnets
  vpc_id = aws_vpc.PMKVPC.id
  
  availability_zone = each.value.zone
  cidr_block = each.value.cidr
  tags = {
    Name=each.value.Name
  }
  
}
resource "aws_route_table_association" "PMKPrivateRTAssociation" {
  for_each = aws_subnet.PMKPrivateSubnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.PMKPrivateRT.id
}