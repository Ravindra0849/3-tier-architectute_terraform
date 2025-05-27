variable "env" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "web_subnets" {}   # aws_subnet.web_subnets[*].id  pass this as value in the code of dev, prod and stage
variable "app_subnets" {}   # aws_subnet.app_subnets[*].id  pass this as value in the code of dev, prod and stage
variable "project" {}
variable "web_tier_sg" {}
variable "app_tier_sg" {}
variable "web_tg_arn" {}
variable "app_tg_arn" {}