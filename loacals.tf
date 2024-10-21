locals {
  subnet_id = { for k, v in aws_subnet.this : v.tags.Name => v.id }
  common_tags = {
    Project   = "infra eks terraform"
    CreatedAt = "2024-10-20"
    ManagedBy = "Terraform"
    Owner     = "Pedro Ribeiro"
    Service   = "Auto Scaling App"
  }
}
