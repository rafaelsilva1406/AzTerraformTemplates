variable "resource_group_location" {
  type        = string
  description = "Location of the resource group."
  default     = "westus"
}

variable "resource_group_name_prefix" {
  type        = string
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
  default     = "sandbox1"
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account for static website hosting."
  default     = "portfolioblobrs"
}

variable "app_service_plan_name" {
  type        = string
  description = "Name of the App Service Plan."
  default     = "webapp-asp"
}

variable "web_app_name" {
  type        = string
  description = "Name of the web application."
  default     = "portfolio-rs"
}

variable "github_repo_url" {
  type        = string
  description = "GitHub repository URL for the Node.js application."
  default     = "https://github.com/rafaelsilva1406/portfolio"
}

variable "github_branch" {
  type        = string
  description = "GitHub branch to deploy from."
  default     = "main"
}

variable "app_insights_name" {
  type        = string
  description = "Name of the Application Insights resource."
  default     = "portfolio-app-insights"
}