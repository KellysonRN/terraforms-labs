resource "azurerm_resource_group" "rg_labs" {
  name     = "rg-${var.website_name}-exp-${var.location}"
  location = var.location
  tags = var.tags
}

resource "azurerm_static_site" "web" {
  name                = "web-${var.website_name}-exp-${var.location}"
  resource_group_name = azurerm_resource_group.rg_labs.name
  location            = var.location
  tags = var.tags
}
