resource "aws_wafv2_ip_set" "default" {
  count = local.enabled ? 1 : 0

  name               = module.this.id
  description        = var.description
  scope              = var.scope
  ip_address_version = var.ip_address_version
  addresses          = var.addresses
  tags               = module.this.tags
}
