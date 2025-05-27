resource "aws_security_group" "external_lb_sg" {
  name        = "External-Load-balancer-SG"
  description = "Allow HTTP from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name   = "${var.env}_External-LB_Sg"
    env    = var.env
    Tier   = "External-LB"
    project_Name = var.project
  }
}

resource "aws_security_group" "web_tier_sg" {
  name        = "Web-tier-SG"
  description = "Allow HTTP from External Load Balancer SG"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP from External Load Balancer SG"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.external_lb_sg.id]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name   = "${var.env}_Web_Sg"
    env    = var.env
    Tier   = "Web"
    project_Name = var.project
  }
}

resource "aws_security_group" "internal_lb_sg" {
  name        = "Internal-Load-balancer-SG"
  description = "Allow HTTP from Web Tier SG"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP from Web Tier SG"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.web_tier_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name   = "${var.env}_Internal-LB_Sg"
    env    = var.env
    Tier   = "Internal-LB"
    project_Name = var.project
  }
}

resource "aws_security_group" "app_tier_sg" {
  name        = "App-tier-SG"
  description = "Allow TCP 4000 from Internal Load Balancer SG"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Custom TCP 4000 from Internal Load Balancer SG"
    from_port        = 4000
    to_port          = 4000
    protocol         = "tcp"
    security_groups  = [aws_security_group.internal_lb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name   = "${var.env}_app_Sg"
    env    = var.env
    Tier   = "App"
    project_Name = var.project
  }
}

resource "aws_security_group" "db_tier_sg" {
  name        = "DB-tier-SG"
  description = "Allow MySQL 3306 from App Tier SG"
  vpc_id      = var.vpc_id

  ingress {
    description      = "MySQL 3306 from App Tier SG"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.app_tier_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = {
    Name   = "${var.env}_DB_Sg"
    env    = var.env
    Tier   = "DB"
    project_Name = var.project
  }
}