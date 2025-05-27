resource "aws_vpc" "my_vpc" {
  cidr_block           = var.cidr_vpc
  enable_dns_support   = var.dns_support
  enable_dns_hostnames = var.hostnames
  instance_tenancy     = var.tendency

  tags = {
    Name   = "${var.env}_VPC"
    owner  = var.owner
    teamDL = var.teamDL
    env    = var.env
    project_Name = var.project
  }
}