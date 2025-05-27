resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name   = "${var.env}_IGW"
    owner  = var.owner
    teamDL = var.teamDL
    env    = var.env
    Project_Name = var.project
  }
}