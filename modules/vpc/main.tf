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

resource "aws_subnet" "frontend" {
  count             = length(var.frontend_subnet)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.frontend_subnet[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-frontend_subnet-${count.index+1}"
  }

}

resource "aws_route_table" "frontend" {
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

#Route Association

resource "aws_route_table_association" "frontend" {
  count          = length(var.frontend_subnet)
  subnet_id      = aws_subnet.frontend[count.index].id
  route_table_id = aws_route_table.frontend[count.index].id
}


resource "aws_subnet" "backend" {
  count             = length(var.backend_subnet)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.backend_subnet[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-backend_subnet-${count.index+1}"
  }

}

resource "aws_route_table" "backend" {
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

#Association

resource "aws_route_table_association" "backend" {
  count          = length(var.backend_subnet)
  subnet_id      = aws_subnet.backend[count.index].id
  route_table_id = aws_route_table.backend[count.index].id
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

resource "aws_route_table" "db" {
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

#Association

resource "aws_route_table_association" "db" {
  count          = length(var.db_subnet)
  subnet_id      = aws_subnet.db_subnet[count.index].id
  route_table_id = aws_route_table.db[count.index].id
}


resource "aws_subnet" "public" {
  count             = length(var.public_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "${var.env}-public_subnet-${count.index+1}"

  }
}

resource "aws_route_table" "public" {
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

#Association

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
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
