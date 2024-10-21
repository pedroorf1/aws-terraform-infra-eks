output "vpc_id" {
  value = aws_vpc.this.id
}
output "igw_id" {
  value = aws_internet_gateway.this.id
}
output "subnets" {
  value = local.subnet_id
}
output "route_table_public" {
  value = aws_route_table.public.id
}
output "route_table_private" {
  value = aws_route_table.private.id
}
output "route_table_associations_ids" {
  value = [for k, v in aws_route_table_association.this : v.id]
}
