output "natgw_ids" {
  value = aws_nat_gateway.nat_gw[*].id
}

output "eips" {
  value = aws_eip.nat_eip[*].public_ip
}
