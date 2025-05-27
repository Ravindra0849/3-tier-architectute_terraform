variable "azs" { type = list(string) }
variable "env" { type = string }
variable "vpc_id" {}
variable "project" {}
variable "igw_id" {}
variable "nat_id" {}
variable "web_subnet_ids" {}
variable "app_subnet_ids" {}
variable "db_subnet_ids" {}