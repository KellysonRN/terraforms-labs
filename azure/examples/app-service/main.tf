resource "azurerm_service_plan" "service_plan" {
  name                = "serviceplan-${var.proof_name}-exp-${var.location}"
  location            = var.location
  resource_group_name = var.rg
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "api-${var.proof_name}-exp-${var.location}"
  location            = var.location
  resource_group_name = var.rg
  service_plan_id     = azurerm_service_plan.service_plan.id
  https_only          = true
  site_config {
    minimum_tls_version = "1.2"
    always_on           = false
  }
}

resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id                 = azurerm_linux_web_app.webapp.id
  repo_url               = var.repo
  branch                 = "main"
  use_manual_integration = true
  use_mercurial          = false
}
