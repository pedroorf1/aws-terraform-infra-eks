
resource "aws_vpc" "this" {
  cidr_block = "192.168.0.0/16"
  tags       = merge(local.common_tags, { Name = "Terraform VPC" })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.common_tags, { Name = "Terraform GATWAY" })
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.0.0/24"
  availability_zone = "${var.region}a"
  tags              = merge(local.common_tags, { Name = "Terraform SUB_PUBLIC_a" })
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "${var.region}b"
  tags              = merge(local.common_tags, { Name = "Terraform SUB_PUBLIC_b" })
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "${var.region}a"
  tags              = merge(local.common_tags, { Name = "Terraform SUB_PRIVATE_a" })
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "${var.region}b"
  tags              = merge(local.common_tags, { Name = "Terraform SUB_PRIVATE_b" })
}
