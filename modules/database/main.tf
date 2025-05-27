resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "${var.env}-mysql-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.env}_mysql_subnet_group"
  }
}

resource "aws_db_instance" "mysql_instance" {
  identifier              = "${var.env}-mysql-instance"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.instance_class
  allocated_storage       = 20
  storage_type            = "gp2"
  username                = var.db_username
  password                = var.db_password
  db_subnet_group_name    = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids  = [var.sg_id]
  publicly_accessible     = false

  # High Availability
  multi_az                = true
  backup_retention_period = 7
  backup_window           = "03:00-04:00"
  maintenance_window      = "Mon:05:00-Mon:06:00"

  # # Failover & protection
  skip_final_snapshot     = true  # use true for failover & protection in RT
  # deletion_protection     = false   # use true for failover & protection in RT

  tags = {
    Name = "${var.env}_mysql_instance"
    env = var.env
    project_name = var.project
  }
}

