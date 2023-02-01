variable "resource_group_name" {
  description = "(Required)A container that holds related resources for an Azure solution."
  type        = string
}

variable "location" {
  description = "(Required)The location to keep all your network resources. To get the list of all locations with table format from azure cli, run 'az account list-locations -o table'."
  type        = string
}

variable "storage_account_name" {
  description = "(Required)The name of the azure storage account."
  type        = string
}

variable "account_replication_type" {
  description = "(Required)Account replication type."
  type        = string
}

variable "account_tier" {
  description = "(Required)Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "(Required)Log analytics workspace id to send logs from the current resource."
  type        = string
  default     = null
}

variable "subnet_id" {
  description = "(Required)Subnet Id in order to create private endpoint."
  type        = string
}

variable "subresource_name" {
  description = "(Required)Name of the subresource corresponding to the target Azure resource. Only valid if `target_resource` is not a Private Link Service."
  type        = string
}

variable "account_kind" {
  description = "(Optional)The type of storage account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  type        = string
  default     = "StorageV2"
}

variable "min_tls_version" {
  description = "(Optional)The minimum supported TLS version for the storage account."
  type        = string
  default     = "TLS1_2"
}

variable "blob_soft_delete_retention_days" {
  description = "(Optional)Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`."
  type        = number
  default     = 7
}

variable "container_soft_delete_retention_days" {
  description = "(Optional)Specifies the number of days that the blob should be retained, between `1` and `365` days. Defaults to `7`."
  type        = number
  default     = 7
}

variable "enable_versioning" {
  description = "(Optional)Is versioning enabled? Default to `false`."
  type        = bool
  default     = false
}

variable "last_access_time_enabled" {
  description = "(Optional)Is the last access time based tracking enabled? Default to `false`."
  type        = bool
  default     = false
}

variable "managed_identity_type" {
  description = "(Optional)The type of Managed Identity which should be assigned to the Linux Virtual Machine. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned`."
  default     = null
  type        = string
}

variable "managed_identity_ids" {
  description = "(Optional)A list of User Managed Identity ID's which should be assigned to the Linux Virtual Machine."
  default     = null
  type        = list(string)
}

variable "change_feed_enabled" {
  description = "(Optional)Is the blob service properties for change feed events enabled?"
  type        = bool
  default     = false
}

variable "network_rules" {
  description = "(Optional)Network rules restricing access to the storage account."
  type        = object({ bypass = list(string), ip_rules = list(string), subnet_ids = list(string) })
  default     = null
}

variable "private_dns_zone_ids" {
  description = "(Optional)Specifies the list of Private DNS Zones to include within the private_dns_zone_group."
  type        = list(string)
  default     = []
}