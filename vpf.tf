
resource "aws_vpc" "this" {
  cidr_block = "192.168.0.0/16"
  tags       = merge(local.common_tags, { Name = "Terraform VPC" })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.common_tags, { Name = "Terraform GATWAY" })
}

resource "aws_subnet" "this" {

  for_each = {
    "pub_a" : ["192.168.1.0/24", "${var.region}a", "Terraform SUB_PUBLIC_a"]
    "pub_b" : ["192.168.2.0/24", "${var.region}b", "Terraform SUB_PUBLIC_b"]
    "pvt_a" : ["192.168.3.0/24", "${var.region}a", "Terraform SUB_PRIVATE_a"]
    "pvt_b" : ["192.168.4.0/24", "${var.region}b", "Terraform SUB_PRIVATE_b"]
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value[0]
  availability_zone = each.value[1]
  tags              = merge(local.common_tags, { Name = each.value[2] })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = merge(local.common_tags, { Name = "Terraform ROUTE_TABLE_PUBLIC" })

}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.common_tags, { Name = "Terraform ROUTE_TABLE_PRIVATE" })
}
resource "aws_route_table_association" "this" {
  for_each       = local.subnet_id
  subnet_id      = each.value
  route_table_id = substr(each.key, 0, 2) == "pub" ? aws_route_table.public.id : aws_route_table.private.id
}
# resource "aws_subnet" "public_a" {
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = "192.168.0.0/24"
#   availability_zone = "${var.region}a"
#   tags              = merge(local.common_tags, { Name = "Terraform SUB_PUBLIC_a" })
# }

# resource "aws_subnet" "public_b" {
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = "192.168.1.0/24"
#   availability_zone = "${var.region}b"
#   tags              = merge(local.common_tags, { Name = "Terraform SUB_PUBLIC_b" })
# }

# resource "aws_subnet" "private_a" {
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = "192.168.2.0/24"
#   availability_zone = "${var.region}a"
#   tags              = merge(local.common_tags, { Name = "Terraform SUB_PRIVATE_a" })
# }

# resource "aws_subnet" "private_b" {
#   vpc_id            = aws_vpc.this.id
#   cidr_block        = "192.168.3.0/24"
#   availability_zone = "${var.region}b"
#   tags              = merge(local.common_tags, { Name = "Terraform SUB_PRIVATE_b" })
# }
