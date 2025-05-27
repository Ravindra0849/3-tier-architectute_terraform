# Public Route Table - only one
resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name         = "${var.env}_Web-Public_RT"
    project_Name = var.project
    env          = var.env
  }
}

# Private Route Tables - one per NAT Gateway (or per private subnet)
resource "aws_route_table" "private_rt" {
  count  = length(var.nat_id)
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_id[count.index]
  }

  tags = {
    Name         = "${var.env}_App-Private_RT-${count.index + 1}"
    project_Name = var.project
    env          = var.env
  }
}

# DB Route Tables - one per DB subnet
resource "aws_route_table" "db_rt" {
  vpc_id = var.vpc_id

  # No internet route, only local routes

  tags = {
    Name         = "${var.env}_DB_RT"
    project_Name = var.project
    env          = var.env
  }
}

# Route Table Associations

resource "aws_route_table_association" "web_assoc" {
  count          = length(var.web_subnet_ids)
  subnet_id      = var.web_subnet_ids[count.index]
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "app_assoc" {
  count          = length(var.app_subnet_ids)
  subnet_id      = var.app_subnet_ids[count.index]
  route_table_id = aws_route_table.private_rt[count.index].id
}

resource "aws_route_table_association" "db_assoc" {
  count          = length(var.db_subnet_ids)
  subnet_id      = var.db_subnet_ids[count.index]
  route_table_id = aws_route_table.db_rt.id
}
