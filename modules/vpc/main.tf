resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block


  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block

  tags = {
    Name = "${var.env}-subnet"
  }
}

resource "aws_vpc_peering_connection" "peering_connection" {
  peer_vpc_id = var.default_vpc_Id
  vpc_id      = aws_vpc.main.id
  auto_accept = true
  tags = {
    Name = "${var.env}-vpc-to-default-vpc"
  }
}
