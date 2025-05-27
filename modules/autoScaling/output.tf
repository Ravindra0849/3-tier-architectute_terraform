# Fetch Web ASG EC2 instance IDs
data "aws_autoscaling_group" "web_asg_data" {
  name = aws_autoscaling_group.web_asg.name
}

data "aws_instances" "web_instances" {
  instance_tags = {
    Name = "${var.project}-web_asg"
  }

  filter {
    name   = "instance.group-name"
    values = [aws_autoscaling_group.web_asg.name]
  }

  depends_on = [aws_autoscaling_group.web_asg]
}

output "web_instance_ids" {
  description = "Instance IDs of web tier EC2 instances"
  value       = data.aws_instances.web_instances.ids
}


# Fetch App ASG EC2 instance IDs
data "aws_autoscaling_group" "app_asg_data" {
  name = aws_autoscaling_group.app_asg.name
}

data "aws_instances" "app_instances" {
  instance_tags = {
    Name = "${var.project}-app_asg"
  }

  filter {
    name   = "instance.group-name"
    values = [aws_autoscaling_group.app_asg.name]
  }

  depends_on = [aws_autoscaling_group.app_asg]
}

output "app_instance_ids" {
  description = "Instance IDs of app tier EC2 instances"
  value       = data.aws_instances.app_instances.ids
}
