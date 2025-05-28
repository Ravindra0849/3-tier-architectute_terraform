# --------------------------------
# Auto Scaling Groups for web-tier
# --------------------------------

resource "aws_launch_template" "web_lt" {
  name_prefix   = "${var.env}_Web_LT_"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = base64encode(<<EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install nginx -y
  sudo systemctl enable nginx
  sudo systemctl start nginx
  EOF
  )

  lifecycle {
    create_before_destroy = true
  }

  network_interfaces {
    security_groups = [var.web_tier_sg]
    associate_public_ip_address = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name   = "${var.env}_web-Ltemplate"
      env    = var.env
      project_Name = var.project
    }
  }
}


resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = var.web_subnets
  health_check_type = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  target_group_arns = [var.web_tg_arn]

  tag {
    key                 = "Name"
    value               = "${var.project}-web_asg"
    propagate_at_launch = true
  }
}

# --------------------------------
# Auto Scaling Groups for App-tier
# --------------------------------

resource "aws_launch_template" "app_lt" {
  name_prefix   = "${var.env}_App_LT_"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
 

  network_interfaces {
    security_groups = [var.app_tier_sg]
    associate_public_ip_address = false
  }

  lifecycle {
    create_before_destroy = true
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name   = "${var.env}_app-Ltemplate"
      env    = var.env
      project_Name = var.project
    }
  }
}


resource "aws_autoscaling_group" "app_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier  = var.app_subnets
  health_check_type = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.app_lt.id
    version = "$Latest"
  }

  target_group_arns = [var.app_tg_arn]

  tag {
    key                 = "Name"
    value               = "${var.project}-app_asg"
    propagate_at_launch = true
  }
}