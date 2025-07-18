output "primary_web_host" {
  description = "Static website URL"
  value       = azurerm_storage_account.storage_account.primary_web_host
}

output "web_app_url" {
  description = "Web application URL"
  value       = "https://${azurerm_linux_web_app.webapp.default_hostname}"
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.storage_account.name
}

output "app_service_plan_name" {
  description = "Name of the App Service Plan"
  value       = azurerm_service_plan.appserviceplan.name
}

output "web_app_name" {
  description = "Name of the web application"
  value       = azurerm_linux_web_app.webapp.name
}