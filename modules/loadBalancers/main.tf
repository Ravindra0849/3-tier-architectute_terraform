resource "aws_lb" "external_lb" {
  name               = "${var.env}-external-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.external_lb_sg_id]
  subnets            = var.web_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name        = "${var.env}-external-lb"
    project_Name = var.project
  }
}

resource "aws_lb_target_group" "web_tg" {
  name     = "${var.env}-web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    enabled = true
    path                = "/"
    protocol            = "HTTP"
    port = 80
    interval            = 300
    timeout             = 60
    healthy_threshold   = 5
    unhealthy_threshold = 5
    matcher = 200
  }

  tags = {
    Name        = "${var.env}-web-tg"
    project_Name = var.project
  }
}

resource "aws_lb_listener" "external_lb_listener" {
  load_balancer_arn = aws_lb.external_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}


# Internal Load Balancer

resource "aws_lb" "internal_lb" {
  name               = "${var.env}-internal-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.internal_lb_sg_id]
  subnets            = var.app_subnet_ids

  enable_deletion_protection = false

  tags = {
    Name        = "${var.env}-internal-lb"
    project_Name = var.project
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "${var.env}-app-tg"
  port     = 4000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    enabled = true
    path                = "/"
    protocol            = "HTTP"
    interval            = 300
    timeout             = 60
    healthy_threshold   = 5
    unhealthy_threshold = 5
    matcher = 200
  }

  tags = {
    Name        = "${var.env}-app-tg"
    project_Name = var.project
  }
}

resource "aws_lb_listener" "internal_lb_listener" {
  load_balancer_arn = aws_lb.internal_lb.arn
  port              = 4000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

