output "vpc_id" {
  value = aws_vpc.main.id
}

output "frontend_subnets" {
  value = aws_subnet.frontend_subnet.*.id
}

output "backend_subnets" {
  value = aws_subnet.backend_subnet.*.id
}

output "db_subnets" {
  value = aws_subnet.db_subnet.*.id
}