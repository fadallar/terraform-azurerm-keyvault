// Key Vault Secrets User
resource "azurerm_user_assigned_identity" "keyvault_secrets_user" {
  location            = var.location
  name                = format("id-secrets-user-%s", azurerm_key_vault.keyvault.name)
  resource_group_name = var.resource_group_name
  tags                = var.default_tags
}

resource "azurerm_role_assignment" "rbac_keyvault_secrets_users" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.keyvault_secrets_user.principal_id
}

// Key Vault Crypto User

resource "azurerm_user_assigned_identity" "keyvault_crypto_user" {
  location            = var.location
  name                = format("id-crypto-users-%s", azurerm_key_vault.keyvault.name)
  resource_group_name = var.resource_group_name
  tags                = var.default_tags
}

resource "azurerm_role_assignment" "rbac_keyvault_crypto_users" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "Key Vault Crypto User"
  principal_id         = azurerm_user_assigned_identity.keyvault_crypto_user.principal_id
}

// Key Vault Administrator

resource "azurerm_user_assigned_identity" "keyvault_administrator" {
  location            = var.location
  name                = format("id-administrator-%s", azurerm_key_vault.keyvault.name)
  resource_group_name = var.resource_group_name
  tags                = var.default_tags
}

resource "azurerm_role_assignment" "rbac_keyvault_administrator" {
  scope                = azurerm_key_vault.keyvault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.keyvault_administrator.principal_id
}

// Key Vault Policies if RBAC is not Used
// Need to reviw this
resource "azurerm_key_vault_access_policy" "readers_policy" {
  for_each = toset(var.rbac_authorization_enabled ? [] : var.reader_objects_ids)

  object_id    = each.value
  tenant_id    = local.tenant_id
  key_vault_id = azurerm_key_vault.keyvault.id

  key_permissions = [
    "Get",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]

  certificate_permissions = [
    "Get",
    "List",
  ]
}

resource "azurerm_key_vault_access_policy" "admin_policy" {
  for_each = toset(var.rbac_authorization_enabled ? [] : var.admin_objects_ids)

  object_id    = each.value
  tenant_id    = local.tenant_id
  key_vault_id = azurerm_key_vault.keyvault.id

  key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
  ]

  secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]

  certificate_permissions = [
    "Backup",
    "Create",
    "Delete",
    "DeleteIssuers",
    "Get",
    "GetIssuers",
    "Import",
    "List",
    "ListIssuers",
    "ManageContacts",
    "ManageIssuers",
    "Purge",
    "Recover",
    "Restore",
    "SetIssuers",
    "Update",
  ]
}