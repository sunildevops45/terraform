
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_id
  }

  tags = {
    Name = var.name
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.private.id
}
