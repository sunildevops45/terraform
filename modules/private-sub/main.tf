
resource "aws_subnet" "private" {
  vpc_id     = var.vpc_id
  cidr_block = var.cidr

  tags = {
    Name = var.name
  }
}
