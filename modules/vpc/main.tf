#VPC

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "${var.env}-vpc"
  }
}

#Peering connection

resource "aws_vpc_peering_connection" "peering_connection" {
  peer_vpc_id = var.default_vpc_Id   #Acceptor
  vpc_id      = aws_vpc.main.id      #Requestor
  auto_accept = true
  tags = {
    Name = "${var.env}-vpc-to-default-vpc"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.env}-igw"
  }
}

#SUBNETS along with their respective route table -

resource "aws_subnet" "frontend_subnet" {
  count             = length(var.frontend_subnet)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.frontend_subnet[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-frontend_subnet-${count.index+1}"
  }

}

resource "aws_route_table" "frontend_route" {
  count        = length(var.frontend_subnet)
  vpc_id       = aws_vpc.main.id

  route {
    cidr_block                = var.default_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  }

  tags = {
    Name = "${var.env}-frontend_route_table-${count.index+1}"
  }
}

resource "aws_subnet" "backend_subnet" {
  count             = length(var.backend_subnet)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.backend_subnet[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-backend_subnet-${count.index+1}"
  }

}

resource "aws_route_table" "backend_route" {
  count        = length(var.backend_subnet)
  vpc_id       = aws_vpc.main.id

  route {
    cidr_block                = var.default_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  }

  tags = {
    Name = "${var.env}-backend_route_table-${count.index+1}"
  }
}


resource "aws_subnet" "db_subnet" {
  count             = length(var.db_subnet)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-db_subnet-${count.index+1}"
  }

}

resource "aws_route_table" "db_route" {
  count        = length(var.db_subnet)
  vpc_id       = aws_vpc.main.id

  route {
    cidr_block                = var.default_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  }

  tags = {
    Name = "${var.env}-db_route_table-${count.index+1}"
  }
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-public_subnet-${count.index+1}"

  }
}

resource "aws_route_table" "public_route" {
  count        = length(var.public_subnets)
  vpc_id       = aws_vpc.main.id

  route {
    cidr_block                = var.default_vpc_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  }

  tags = {
    Name = "${var.env}-public_route_table-${count.index+1}"
  }
}

#This is no more needed as each subnet now will get its own route table and there we will use peering connection
#resource "aws_route" "main" {
#  route_table_id            = aws_vpc.main.default_route_table_id
#  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
#  destination_cidr_block    = var.default_vpc_cidr
#}


resource "aws_route" "default-vpc" {
  route_table_id            = var.default_vpc_route_table_id
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection.id
  destination_cidr_block    = var.vpc_cidr_block
}



#resource "aws_route" "igw_route" {
#  count = length(var.public_subnets)
#  route_table_id = aws_internet_gateway.igw.id
#  destination_cidr_block = var.public_subnets[count.index]
#}