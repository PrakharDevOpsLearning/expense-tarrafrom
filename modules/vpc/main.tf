resource "aws_vpc" "main" {
  cidr_block = var.cidr_block


  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.env}-subnet"
  }
}
