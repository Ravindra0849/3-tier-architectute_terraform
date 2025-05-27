output "external_lb_dns_name" {
  description = "DNS name of the external (public) Application Load Balancer"
  value       = aws_lb.external_lb.dns_name
}

output "internal_lb_dns_name" {
  description = "DNS name of the internal (private) Application Load Balancer"
  value       = aws_lb.internal_lb.dns_name
}

output "web_tg_arn" {
  value = aws_lb_target_group.web_tg.arn
}

output "app_tg_arn" {
  value = aws_lb_target_group.app_tg.arn
}

