variable "vpc_id" {}
variable "azs" { type = list(string) }
variable "web_subnet_cidr" { type = list(string) }
variable "app_subnet_cidr" { type = list(string) }
variable "db_subnet_cidr" { type = list(string) }
variable "env" { type = string }
variable "owner" { type = string }
variable "teamDL" { type = string }
variable "project" {}