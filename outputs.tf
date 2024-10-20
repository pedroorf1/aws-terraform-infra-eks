output "vpc_id" {
  value = aws_vpc.this.id
}
output "igw_id" {
  value = aws_internet_gateway.this.id
}
output "subnets" {
  value = { for k, v in aws_subnet.this : v.tags.Name => v.id }
}
