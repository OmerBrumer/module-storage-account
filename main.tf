/**
* # Azure Storage Account with Private Endpoint and Diagnostic Setting module
*/

resource "azurerm_storage_account" "storeacc" {
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_kind                    = var.account_kind
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  enable_https_traffic_only       = true
  min_tls_version                 = var.min_tls_version
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false

  dynamic "identity" {
    for_each = var.managed_identity_type == null ? [] : [var.managed_identity_type]

    content {
      type         = var.managed_identity_type
      identity_ids = var.managed_identity_ids == null ? 0 : 1
    }
  }

  blob_properties {
    delete_retention_policy {
      days = var.blob_soft_delete_retention_days
    }
    container_delete_retention_policy {
      days = var.container_soft_delete_retention_days
    }
    versioning_enabled       = var.enable_versioning
    last_access_time_enabled = var.last_access_time_enabled
    change_feed_enabled      = var.change_feed_enabled
  }

  dynamic "network_rules" {
    for_each = var.network_rules == null ? [] : [var.network_rules]

    content {
      default_action             = "Deny"
      bypass                     = var.network_rules.bypass
      ip_rules                   = var.network_rules.ip_rules
      virtual_network_subnet_ids = var.network_rules.subnet_ids
    }
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

module "private_endpoint" {
  source = "git::https://github.com/OmerBrumer/module-private-endpoint.git?ref=dev"

  private_endpoint_name          = "${var.storage_account_name}-private-endpoint"
  resource_group_name            = var.resource_group_name
  location                       = var.location
  private_connection_resource_id = azurerm_storage_account.storeacc.id
  subnet_id                      = var.subnet_id
  subresource_name               = var.subresource_name
}

module "diagnostic_settings" {
  source = "git::https://github.com/OmerBrumer/module-diagnostic-setting.git?ref=dev"

  diagonstic_setting_name    = "${azurerm_storage_account.storeacc.name}-diagnostic-setting"
  log_analytics_workspace_id = var.log_analytics_workspace_id
  target_resource_id         = azurerm_storage_account.storeacc.id
}