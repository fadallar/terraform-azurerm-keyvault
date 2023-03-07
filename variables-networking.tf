variable "private_dns_zone_ids" {
  description = "Id of the private DNS Zone  to be used by the Vault private endpoint"
  type        = string
}

variable "private_subnet_id" {
  description = "Id for the subnet used by the vault private endpoint"
  type        = string
}

variable "network_rules_trusted" {
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None"
  type        = string
  default     = "AzureServices"
}

variable "allowed_subnets" {
  description = "List of VNet/Subnet IDs to allow on the registry."
  default     = []
  type        = list(string)
}

variable "allowed_cidrs" {
  description = "List of CIDRs to allow on the registry"
  default     = []
  type        = list(string)
}


variable "public_network_access_enabled" {
  description = "Whether the Key Vault is available from public network."
  type        = bool
  default     = false
}

variable "enable_private_endpoint" {
  description = "Wheter private endpoint is enabled or not"
  type        = bool
  default     = true
}
