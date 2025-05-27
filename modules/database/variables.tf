variable "db_username" { type = string }
variable "db_password" { 
    type = string 
    sensitive = true 
}
variable "project" {}
variable "env" { type = string }
variable "subnet_ids" {}    # aws_subnet.db_subnets[*].id
variable "instance_class" {}    # "db.t3.medium"
variable "sg_id" {}     # [aws_security_group.db_tier_sg.id]
