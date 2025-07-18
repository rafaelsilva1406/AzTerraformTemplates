# main.tf

# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name_prefix
  location = var.resource_group_location
  tags = {
    environment = "dev"
    source      = "Terraform"
    owner       = "terraform"
  }
}

# Create storage account for static website hosting (low cost)
resource "azurerm_storage_account" "storage_account" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  name = var.storage_account_name

  # Use Standard tier for cost optimization
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  # Enable static website hosting
  static_website {
    index_document = "index.html"
    error_404_document = "index.html"  # SPA fallback
  }

  tags = {
    environment = "dev"
    purpose     = "static-website"
  }
}

# Create container for static files
resource "azurerm_storage_blob" "webapp" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = var.storage_container_name
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}

# Create the Linux App Service Plan (low cost B1 tier)
resource "azurerm_service_plan" "appserviceplan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"  # Basic tier for cost optimization
  
  tags = {
    environment = "dev"
    purpose     = "nodejs-app"
  }
}

# Create the web app for Node.js
resource "azurerm_linux_web_app" "webapp" {
  name                = var.web_app_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.appserviceplan.id
  depends_on          = [azurerm_service_plan.appserviceplan]
  https_only          = true
  
  site_config {
    minimum_tls_version = "1.2"
    application_stack {
      node_version = "20-lts"
    }
    
    # Enable application insights for monitoring
    application_insights_connection_string = azurerm_application_insights.app_insights.connection_string
    application_insights_key               = azurerm_application_insights.app_insights.instrumentation_key
  }

  tags = {
    environment = "dev"
    purpose     = "nodejs-app"
  }
}

# Deploy code from GitHub repository
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id                 = azurerm_linux_web_app.webapp.id
  repo_url               = var.github_repo_url
  branch                 = var.github_branch
  use_manual_integration = true
  use_mercurial          = false
  
  depends_on = [azurerm_linux_web_app.webapp]
}

# Application Insights for monitoring (free tier)
resource "azurerm_application_insights" "app_insights" {
  name                = var.app_insights_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
  
  tags = {
    environment = "dev"
    purpose     = "monitoring"
  }
}