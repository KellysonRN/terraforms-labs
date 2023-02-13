variable "website_name" {
  description = "The name od your static website"
  type        = string
  default     = "Kellyson's Labs"
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