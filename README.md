# Azure Terraform Templates - Static Website + Node.js App Service

This Terraform configuration creates a cost-optimized Azure infrastructure with:
- **Static Website Hosting** using Azure Storage Account
- **Node.js Web Application** using Azure App Service
- **GitHub Integration** for continuous deployment
- **Application Insights** for monitoring

## 🏗️ Infrastructure Components

### 1. Static Website (Low Cost)
- **Azure Storage Account** with static website hosting enabled
- **Standard tier** with LRS replication for cost optimization
- **$web container** for hosting static files
- **HTTPS enabled** with TLS 1.2 minimum

### 2. Node.js App Service (Low Cost)
- **Linux App Service Plan** using B1 (Basic) tier
- **Node.js 20 LTS** runtime
- **HTTPS only** with TLS 1.2 minimum
- **GitHub integration** for source control

### 3. Monitoring
- **Application Insights** (free tier) for application monitoring
- **Performance monitoring** and error tracking

## 💰 Cost Optimization Features

- **Storage Account**: Standard tier with LRS (cheapest option)
- **App Service Plan**: B1 Basic tier (lowest paid tier)
- **Application Insights**: Free tier included
- **Resource Group**: Centralized management for easy cleanup

## 🚀 Quick Start

### Prerequisites
- Azure CLI installed and authenticated
- Terraform installed (version >= 0.14.9)
- GitHub repository with your Node.js application

### 1. Clone and Configure
```bash
# Clone this repository
git clone <your-repo-url>
cd AzTerraformTemplates

# Initialize Terraform
terraform init
```

### 2. Customize Variables (Optional)
Edit `variables.tf` or create a `terraform.tfvars` file:

```hcl
# terraform.tfvars
resource_group_location = "eastus"
resource_group_name_prefix = "my-portfolio"
storage_account_name = "mystaticwebsite"
web_app_name = "my-nodejs-app"
github_repo_url = "https://github.com/yourusername/your-repo"
github_branch = "main"
```

### 3. Deploy Infrastructure
```bash
# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

### 4. Access Your Applications
After deployment, you'll get:
- **Static Website URL**: `https://<storage-account>.z13.web.core.windows.net`
- **Web App URL**: `https://<web-app-name>.azurewebsites.net`

## 📁 File Structure

```
AzTerraformTemplates/
├── main.tf              # Main infrastructure configuration
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── providers.tf         # Provider configuration
├── index.html           # Sample static website file
├── README.md           # This file
└── *.sh                # Helper scripts
```

## 🔧 Configuration Details

### Storage Account
- **Tier**: Standard (cost-effective)
- **Replication**: LRS (Locally Redundant Storage)
- **Static Website**: Enabled with index.html
- **HTTPS**: Enabled by default

### App Service
- **OS**: Linux
- **Runtime**: Node.js 20 LTS
- **Plan**: B1 Basic (1 CPU, 1.75 GB RAM)
- **HTTPS**: Enforced
- **TLS**: Minimum 1.2

### GitHub Integration
- **Manual Integration**: Set to true for controlled deployments
- **Branch**: Configurable (default: main)
- **Auto-deploy**: Disabled for manual control

## 🛠️ Customization Options

### Change Node.js Version
Edit the `application_stack` block in `main.tf`:
```hcl
application_stack {
  node_version = "18-lts"  # or "16-lts", "14-lts"
}
```

### Upgrade App Service Plan
Change the `sku_name` in the App Service Plan:
```hcl
sku_name = "S1"  # Standard tier
sku_name = "P1v2"  # Premium tier
```

### Add Custom Domain
Add to the web app configuration:
```hcl
site_config {
  # ... existing config ...
  
  custom_domain_verification_id = "your-verification-id"
}
```

## 🧹 Cleanup

To destroy all resources:
```bash
terraform destroy
```

## 📊 Cost Estimation

Estimated monthly costs (US East region):
- **Storage Account (Standard LRS)**: ~$0.02/GB
- **App Service Plan (B1)**: ~$13/month
- **Application Insights**: Free tier included
- **Total**: ~$13-15/month for basic setup

## 🔒 Security Features

- **HTTPS Only**: All endpoints enforce HTTPS
- **TLS 1.2+**: Minimum TLS version enforced
- **Resource Tags**: Proper tagging for cost tracking
- **Resource Group Isolation**: All resources in dedicated group

## 🐛 Troubleshooting

### Common Issues

1. **Storage Account Name Already Exists**
   - Change `storage_account_name` variable
   - Storage account names must be globally unique

2. **GitHub Repository Access**
   - Ensure repository is public or configure GitHub authentication
   - Check branch name exists in repository

3. **App Service Deployment Fails**
   - Verify Node.js application has proper `package.json`
   - Check for build scripts and dependencies

### Getting Help

- Check Azure Portal for detailed error messages
- Review Application Insights for application errors
- Use `terraform plan` to validate configuration changes

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.
