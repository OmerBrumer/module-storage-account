output "id" {
  description = "Id of storage account."
  value       = azurerm_storage_account.storeacc.id
}

output "name" {
  description = "Name of storage account."
  value       = azurerm_storage_account.storeacc.name
}

output "object" {
  description = "Object of storage account."
  value       = azurerm_storage_account.storeacc
}