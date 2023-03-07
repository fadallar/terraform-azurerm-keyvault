resource "azurerm_key_vault" "keyvault" {
  name = local.name

  location            = var.location
  resource_group_name = var.resource_group_name

  tenant_id = local.tenant_id

  sku_name = var.sku_name

  enabled_for_deployment          = var.enabled_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment

  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days

  enable_rbac_authorization = var.rbac_authorization_enabled

  public_network_access_enabled = var.public_network_access_enabled

  dynamic "network_acls" {
    for_each = var.allowed_cidrs != null || var.allowed_subnets != null || var.network_rules_trusted != "None" ? ["Enabled"] : []

    content {
      bypass                     = var.network_rules_trusted
      default_action             = "Deny"
      ip_rules                   = var.allowed_cidrs
      virtual_network_subnet_ids = var.allowed_subnets
    }
  }

  tags = merge(var.default_tags, var.extra_tags)

}

