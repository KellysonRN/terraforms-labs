variable "proof_name" {
  description = "The name od your static website"
  type        = string
}

variable "location" {
  description = "Azure location this azure StorageAccount should reside in"
  type        = string
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
}

variable "rg" {
  description = "Resources Group"
  type        = string
}

