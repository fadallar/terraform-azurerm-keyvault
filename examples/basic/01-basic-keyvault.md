# Basic Key Vault Set-up


## Main.tf file content
  Please replace the modules source and version with your relevant information  

```hcl  
// Core modules

module "regions_master" {
  source  = "app.terraform.io/<ORGANIZATION>/regions-master/azurem"
  version = "x.y.z"
  azure_region = var.location # example eu-west
}

module "base_tagging" {
  source  = "app.terraform.io/<ORGANIZATION>/base-tagging/azurerm"
  version = "x.y.z"
  environment = var.environment
  stack = var.stack
  spoc =  var.spoc
  change = var.change
  costcenter = var.costcenter
  owner = var.owner
}

// Resource Group
module "ressource" {
    source  = "app.terraform.io/<ORGANIZATION>/rg/azurerm"
    version = "x.y.z"
    environment = var.environment
    stack       = var.stack
    default_tags = module.base-tagging.base_tags
    landing_zone_slug = var.landing_zone_slug
    location    = module.regions_master.location
    location_short  = module.regions_master.location_short
}

module "keyvault" {
  source  = "app.terraform.io/<ORGANIZATION>/keyvault/azurerm"
  version = "x.y.z"
  landing_zone_slug = var.landing_zone_slug
  environment = var.environment
  stack       = var.stack
  location                        = module.regions_master.location
  location_short                  = module.regions_master.location_short
  resource_group_name             = module.rg.resource_group_name
  default_tags                    = module.base-tagging.base_tags
  network_rules_trusted = "AzureServices"
  ### References
  diag_log_analytics_workspace_id = ""    #### Log Analytics Workspace Resource Id
  private_dns_zone_ids = "" ### Key Vault Private DNS zone resource id
  private_subnet_id  = ""  ### Private endpoint subnet resource id
  
}
```