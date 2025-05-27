# ----------------------
# Subnets (Web, App, DB)
# ----------------------

# Web-tier Subnets
resource "aws_subnet" "web_subnets" {
  count             = length(var.web_subnet_cidr)
  vpc_id            = var.vpc_id
  cidr_block        = var.web_subnet_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone = var.azs[count.index]

  tags = {
    Name   = "${var.env}_Web_Subnet-${count.index + 1}"
    owner  = var.owner
    teamDL = var.teamDL
    env    = var.env
    Tier   = "Web"
    project_Name = var.project
  }
}

# App-tier Subnets (Private)
resource "aws_subnet" "app_subnets" {
  count             = length(var.app_subnet_cidr)
  vpc_id            = var.vpc_id
  cidr_block        = var.app_subnet_cidr[count.index]
  map_public_ip_on_launch = false
  availability_zone = var.azs[count.index]

  tags = {
    Name   = "${var.env}_App_Subnet-${count.index + 1}"
    owner  = var.owner
    teamDL = var.teamDL
    env    = var.env
    Tier   = "App"
    project_Name = var.project
  }
}

# DB-tier Subntes

resource "aws_subnet" "db_subnets" {
  count             = length(var.db_subnet_cidr)
  vpc_id            = var.vpc_id
  cidr_block        = var.db_subnet_cidr[count.index]
  map_public_ip_on_launch = false
  availability_zone = var.azs[count.index]

  tags = {
    Name   = "${var.env}_DB_Subnet-${count.index + 1}"
    owner  = var.owner
    teamDL = var.teamDL
    env    = var.env
    Tier   = "DB"
    project_Name = var.project
  }
}