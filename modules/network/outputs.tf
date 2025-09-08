output "vpc_id" { value = aws_vpc.main.id }
output "public_subnet_id" { value = aws_subnet.public.id }
output "private_subnet_id" { value = aws_subnet.private.id }
output "nat_gateway_id" { value = aws_nat_gateway.nat.id }
output "public_subnets" {
  value = [aws_subnet.public.id, aws_subnet.public2.id]
}

output "private_subnets" {
  value = [aws_subnet.private.id, aws_subnet.private2.id]
}

