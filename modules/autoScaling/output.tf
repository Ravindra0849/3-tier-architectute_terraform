output "app_asg_id" {
  value = aws_autoscaling_group.app_asg.id
}

output "web_asg_id" {
  value = aws_autoscaling_group.web_asg.id
}