# Azure Key Vault

This Terraform module creates an Azure Key Vault.
  - It generates an Key Vault resource name following our naming convention
  - It applies a default diagnostics settings  
  - It configures a private endpoint if private access is enabled
  - it configures KeyVault Firewall policy if ip acl and pr virtual subnet ids are defined
  - It configures Key Vault firewall if public network access is enabled
  - It configures user managed identities scoped at the Key Vault for Secrets and Key Management and Key Vault data plane admin

The module also supports Key Vault Access Policy (although this is not the preferred choice)

>You can overide the generated name using the custom_name parameter

> Important  
> Ensures you have the required permissions to associate a role to a user managed identity  

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.22 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.4.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.22 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.admin_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.readers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_monitor_diagnostic_setting.diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.keyvaultpep](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.rbac_keyvault_administrator](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_keyvault_crypto_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_keyvault_secrets_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.keyvault_administrator](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.keyvault_crypto_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_user_assigned_identity.keyvault_secrets_user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [random_string.random](https://registry.terraform.io/providers/hashicorp/random/3.4.3/docs/resources/string) | resource |
| [azurerm_client_config.current_config](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_diag_log_analytics_workspace_id"></a> [diag\_log\_analytics\_workspace\_id](#input\_diag\_log\_analytics\_workspace\_id) | Log Analytics Workspace Id for logs and metrics diagnostics destination | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name | `string` | n/a | yes |
| <a name="input_landing_zone_slug"></a> [landing\_zone\_slug](#input\_landing\_zone\_slug) | Landing zone acronym,it will beused to generate the resource nae | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Azure location for Key Vault. | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | Short string for Azure location. | `string` | n/a | yes |
| <a name="input_private_dns_zone_ids"></a> [private\_dns\_zone\_ids](#input\_private\_dns\_zone\_ids) | Id of the private DNS Zone  to be used by the Vault private endpoint | `string` | n/a | yes |
| <a name="input_private_subnet_id"></a> [private\_subnet\_id](#input\_private\_subnet\_id) | Id for the subnet used by the vault private endpoint | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource Group the resources will belong to | `string` | n/a | yes |
| <a name="input_stack"></a> [stack](#input\_stack) | Stack name | `string` | n/a | yes |
| <a name="input_admin_objects_ids"></a> [admin\_objects\_ids](#input\_admin\_objects\_ids) | IDs of the objects that can do all operations on all keys, secrets and certificates. | `list(string)` | `[]` | no |
| <a name="input_allowed_cidrs"></a> [allowed\_cidrs](#input\_allowed\_cidrs) | List of CIDRs to allow on the registry | `list(string)` | `[]` | no |
| <a name="input_allowed_subnets"></a> [allowed\_subnets](#input\_allowed\_subnets) | List of VNet/Subnet IDs to allow on the registry. | `list(string)` | `[]` | no |
| <a name="input_custom_name"></a> [custom\_name](#input\_custom\_name) | Custom Azure Key Vault Name, it will overide the generate name if set | `string` | `""` | no |
| <a name="input_default_tags"></a> [default\_tags](#input\_default\_tags) | Default Base tagging | `map(string)` | `{}` | no |
| <a name="input_default_tags_enabled"></a> [default\_tags\_enabled](#input\_default\_tags\_enabled) | Option to enable or disable default tags. | `bool` | `true` | no |
| <a name="input_diag_default_setting_name"></a> [diag\_default\_setting\_name](#input\_diag\_default\_setting\_name) | Name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| <a name="input_diag_log_categories"></a> [diag\_log\_categories](#input\_diag\_log\_categories) | List of categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "AuditEvent"<br>]</pre> | no |
| <a name="input_diag_metric_categories"></a> [diag\_metric\_categories](#input\_diag\_metric\_categories) | List of metric categories to enable in the diagnostic settings | `list(string)` | <pre>[<br>  "AllMetrics"<br>]</pre> | no |
| <a name="input_diag_retention_days"></a> [diag\_retention\_days](#input\_diag\_retention\_days) | The number of days for which the Retention Policy should apply | `number` | `30` | no |
| <a name="input_diag_storage_account_id"></a> [diag\_storage\_account\_id](#input\_diag\_storage\_account\_id) | Storage Account Id for logs and metrics diagnostics destination | `string` | `null` | no |
| <a name="input_enable_private_endpoint"></a> [enable\_private\_endpoint](#input\_enable\_private\_endpoint) | Wheter private endpoint is enabled or not | `bool` | `true` | no |
| <a name="input_enabled_for_deployment"></a> [enabled\_for\_deployment](#input\_enabled\_for\_deployment) | Whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the Key Vault. | `bool` | `false` | no |
| <a name="input_enabled_for_disk_encryption"></a> [enabled\_for\_disk\_encryption](#input\_enabled\_for\_disk\_encryption) | Whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | `bool` | `false` | no |
| <a name="input_enabled_for_template_deployment"></a> [enabled\_for\_template\_deployment](#input\_enabled\_for\_template\_deployment) | Whether Azure Resource Manager is permitted to retrieve secrets from the Key Vault. | `bool` | `false` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add. | `map(string)` | `{}` | no |
| <a name="input_log_analytics_destination_type"></a> [log\_analytics\_destination\_type](#input\_log\_analytics\_destination\_type) | Possible values are AzureDiagnostics and Dedicated. Recommended value is Dedicated | `string` | `"Dedicated"` | no |
| <a name="input_network_rules_trusted"></a> [network\_rules\_trusted](#input\_network\_rules\_trusted) | Specifies which traffic can bypass the network rules. Possible values are AzureServices and None | `string` | `"AzureServices"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether the Key Vault is available from public network. | `bool` | `false` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Whether to activate purge protection. | `bool` | `true` | no |
| <a name="input_rbac_authorization_enabled"></a> [rbac\_authorization\_enabled](#input\_rbac\_authorization\_enabled) | Whether the Key Vault uses Role Based Access Control (RBAC) for authorization of data actions instead of access policies. | `bool` | `true` | no |
| <a name="input_reader_objects_ids"></a> [reader\_objects\_ids](#input\_reader\_objects\_ids) | IDs of the objects that can read all keys, secrets and certificates. | `list(string)` | `[]` | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The Name of the SKU used for this Key Vault. Possible values are "standard" and "premium". | `string` | `"standard"` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted. This value can be between `7` and `90` days. | `number` | `7` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | The Azure Active Directory tenant ID that should be used for authenticating requests to the Key Vault. Default is the current one. | `string` | `""` | no |
| <a name="input_workload_info"></a> [workload\_info](#input\_workload\_info) | Workload additional info to be used in the resource name | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_vault_administrator_managed_id"></a> [key\_vault\_administrator\_managed\_id](#output\_key\_vault\_administrator\_managed\_id) | Managed Identity Key Vault Administrator Id |
| <a name="output_key_vault_crypto_user_managed_id"></a> [key\_vault\_crypto\_user\_managed\_id](#output\_key\_vault\_crypto\_user\_managed\_id) | Managed Identity Key Vault Crypto User Id |
| <a name="output_key_vault_id"></a> [key\_vault\_id](#output\_key\_vault\_id) | Id of the Key Vault |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | Name of the Key Vault |
| <a name="output_key_vault_secret_user_managed_id"></a> [key\_vault\_secret\_user\_managed\_id](#output\_key\_vault\_secret\_user\_managed\_id) | Managed Identity Key Vault Secret User Id |
| <a name="output_key_vault_uri"></a> [key\_vault\_uri](#output\_key\_vault\_uri) | URI of the Key Vault |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/key-vault/](https://docs.microsoft.com/en-us/azure/key-vault/)
