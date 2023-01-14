resource "azurerm_private_endpoint" "keyvaultpep" {
  name                = format("pe-%s", local.keyvault_name)
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags = merge(var.default_tags, var.extra_tags)
  
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
}