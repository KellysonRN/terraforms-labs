terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

# ---------
# VARIABLES
# ---------

variable "website_name" {
  description = "The name of your static website"
  type        = string
  default     = "terraform-labs"
}

variable "location" {
  description = "Azure location this azure StorageAccount should reside in"
  type        = string
  default     = "eastus2"
}

variable "force_destroy" {
  description = "Delete all objects from the StorageAccount so that the SA can be destroyed even when not empty"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default = {
    tier = "experimental"
  }
}

resource "azurerm_resource_group" "rg_labs" {
  name     = "rg-${var.website_name}-exp-${var.location}"
  location = var.location
  tags     = var.tags
}


module "staticwapp" {
  source        = "./examples/static-site"
  website_name  = var.website_name
  location      = var.location
  tags          = var.tags
  rg            = azurerm_resource_group.rg_labs.name
}

module "cosmos" {
  source       = "./examples/cosmosdb"
  website_name = var.website_name
  location     = var.location
  tags         = var.tags
  rg            = azurerm_resource_group.rg_labs.name
}

