output "external_lb_sg_id" {
  value = aws_security_group.external_lb_sg.id
}

output "internal_lb_sg_id" {
  value = aws_security_group.internal_lb_sg.id
}

output "web_tier_sg_id" {
  value = aws_security_group.web_tier_sg.id
}

output "app_tier_sg_id" {
  value = aws_security_group.app_tier_sg.id
}

output "db_tier_sg_id" {
  value = aws_security_group.db_tier_sg.id
}
