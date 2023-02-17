resource "azurerm_static_site" "web" {
  name                = "web-${var.proof_name}-exp-${var.location}"
  resource_group_name = var.rg
  location            = var.location
  tags = var.tags
}
