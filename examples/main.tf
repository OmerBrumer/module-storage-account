module "storage_account" {
  source = "./modules/storage/storage_account"

  storage_account_name       = "brumertfstorageaccount"
  resource_group_name        = "brumer-final-terraform-workspoke-rg"
  location                   = "West Europe"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  log_analytics_workspace_id = "/subscriptions/d94fe338-52d8-4a44-acd4-4f8301adf2cf/resourcegroups/brumer-final-terraform-hub-rg/providers/microsoft.operationalinsights/workspaces/brumer-final-terraform-hub-log-analytics"
  subnet_id                  = "/subscriptions/d94fe338-52d8-4a44-acd4-4f8301adf2cf/resourceGroups/brumer-final-terraform-workspoke-rg/providers/Microsoft.Network/virtualNetworks/brumer-final-terraform-workspoke-vnet/subnets/MainSubnet"
  subresource_name           = "blob"
}