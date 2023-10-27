variable "name" {
  type        = string
  description = "Name for the resource."
}

variable "location" {
  type        = string
  description = "Azure region where the resource should be deployed."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Custom tags to apply to the resource."
  default     = {}
}

variable "log_analytics_workspace_customer_id" {
  type        = string
  description = "Customer ID for Log Analytics workspace (optional)."
  default     = null
}

variable "log_analytics_workspace_destination" {
  type        = string
  description = "Destination for Log Analytics (options: 'log-analytics', 'azuremonitor', 'none')."
  default     = "log-analytics"

  validation {
    condition     = contains(["log-analytics", "azuremonitor", "none"], var.log_analytics_workspace_destination)
    error_message = "Invalid value for log_analytics_workspace_destination. Valid options are 'log-analytics', 'azuremonitor', or 'none'."
  }
}

variable "log_analytics_workspace_primary_shared_key" {
  type        = string
  description = "Primary shared key for Log Analytics (optional)."
  default     = null
}

variable "custom_domain_certificate_password" {
  type        = string
  description = "Certificate password for custom domain (optional)."
  default     = null
}

variable "custom_domain_dns_suffix" {
  type        = string
  description = "DNS suffix for custom domain (optional)."
  default     = null
}

variable "instrumentation_key" {
  type        = string
  description = "Instrumentation key for Dapr AI (optional)."
  default     = null
}

variable "peer_authentication_enabled" {
  type        = bool
  description = "Enable peer authentication (Mutual TLS)."
  default     = false
}

variable "vnet_subnet_id" {
  type        = string
  description = "ID of the VNet subnet (optional)."
  default     = null
}

variable "vnet_internal_only" {
  type        = bool
  description = "Restrict access to internal resources within VNet."
  default     = false
}

variable "workload_profiles" {
  type = list(object({
    workload_profile_name      = string
    workload_profile_type      = optional(string, "consumption")
    workload_profile_min_count = optional(number, 3)
    workload_profile_max_count = optional(number, 3)
  }))
  description = "Optional. Workload profiles configured for the Managed Environment."
  default     = []
  validation {
    condition     = var.workload_profiles == null ? true : can([for wp in var.workload_profiles : regex("^[a-za-z][a-za-z0-9_-]{0,14}[a-za-z0-9]$", wp.workload_profile_name)])
    error_message = "Invalid value for workload_profile_name. It must start with a letter, contain only letters, numbers, underscores, or dashes, and not end with an underscore or dash. Maximum 15 characters."
  }
  validation {
    condition     = var.workload_profiles == null ? true : can([for wp in var.workload_profiles : index(["consumption", "D4", "D8", "D16", "D32", "E4", "E8", "E16", "E32"], wp.workload_profile_type) >= 0])
    error_message = "Invalid value for workload_profile_type. Valid options are 'consumption', 'D4', 'D8', 'D16', 'D32', 'E4', 'E8', 'E16', 'E32'."
  }
}

variable "zone_redundancy_enabled" {
  type        = bool
  description = "Enable zone-redundancy for the resource."
  default     = true
}
