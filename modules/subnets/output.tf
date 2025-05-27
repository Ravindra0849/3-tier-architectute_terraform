output "web_subnet_ids" {
  value = aws_subnet.web_subnets[*].id
}

output "app_subnet_ids" {
  value = aws_subnet.app_subnets[*].id
}

output "db_subnet_ids" {
  value = aws_subnet.db_subnets[*].id
}