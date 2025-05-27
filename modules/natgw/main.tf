# Elastic IP
resource "aws_eip" "nat_eip" {
  count  = length(var.azs)
  domain = "vpc"

  tags = {
    Name         = "${var.env}_NAT_EIP-${count.index + 1}"
    env          = var.env
    project_Name = var.project
  }
}

# NAT Gateway
resource "aws_nat_gateway" "nat_gw" {
  count         = length(var.azs)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = var.subnet_ids[count.index]

  tags = {
    Name         = "${var.env}_NAT_GW-${count.index + 1}"
    env          = var.env
    project_Name = var.project
  }
}
