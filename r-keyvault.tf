resource "azurerm_key_vault" "keyvault" {
  name = local.keyvault_name

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
    for_each = var.network_acls == null ? [] : [var.network_acls]
    iterator = acl

    content {
      bypass                     = acl.value.bypass
      default_action             = acl.value.default_action
      ip_rules                   = acl.value.ip_rules
      virtual_network_subnet_ids = acl.value.virtual_network_subnet_ids
    }
  }

  tags = merge(local.default_tags, var.extra_tags)
}
resource "azurerm_private_endpoint" "keyvaultpep" {
  name                = format("pe-%s", local.keyvault_name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags = merge(local.default_tags, var.extra_tags)
  private_dns_zone_group {
    name                 = "keyvault-group"
    private_dns_zone_ids = [var.private_dns_zone_ids]
  }

  private_service_connection {
    name                           = "keyvaultprivatelink"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.keyvault.id
    subresource_names              = ["vault"]
  }
