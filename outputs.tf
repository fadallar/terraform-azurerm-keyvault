output "key_vault_id" {
  description = "Id of the Key Vault"
  value       = azurerm_key_vault.keyvault.id
}

output "key_vault_name" {
  description = "Name of the Key Vault"
  value       = azurerm_key_vault.keyvault.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.keyvault.vault_uri
}

output "key_vault_secret_user_managed_id" {
  description = "Managed Identity Key Vault Secret User Id"
  value       = azurerm_user_assigned_identity.keyvault_secrets_user.id
}

output "key_vault_crypto_user_managed_id" {
  description = "Managed Identity Key Vault Crypto User Id"
  value       = azurerm_user_assigned_identity.keyvault_crypto_user.id
}

output "key_vault_administrator_managed_id" {
  description = "Managed Identity Key Vault Administrator Id"
  value       = azurerm_user_assigned_identity.keyvault_administrator.id
}

