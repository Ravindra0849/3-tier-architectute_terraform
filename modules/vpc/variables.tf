variable "cidr_vpc" { type = string }
variable "dns_support" { type = bool }
variable "hostnames" { type = bool }
variable "tendency" { type = string } # "default" or "dedicated"
variable "env" { type = string }
variable "owner" { type = string }
variable "teamDL" { type = string }
variable "project" {}