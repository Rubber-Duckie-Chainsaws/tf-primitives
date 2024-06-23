resource "aws_subnet" "this" {
  vpc_id = var.vpc_id
  cidr_block = var.cidr_block
  ipv6_cidr_block = var.ipv6_cidr_block

  map_public_ip_on_launch = var.public

  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "egress" {
  count = var.public ? 1 : 0
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-igw"
  }
}

resource "aws_route_table" "main" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-rt"
  }
}

resource "aws_route_table_association" "this" {
  subnet_id = aws_subnet.this.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route" "public-v4" {
  count = var.public ? 1 : 0
  route_table_id = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.egress.0.id
}

resource "aws_route" "public-v6" {
  count = var.public ? 1 : 0
  route_table_id = aws_route_table.main.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id = aws_internet_gateway.egress.0.id
}
