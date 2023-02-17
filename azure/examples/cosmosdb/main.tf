resource "azurerm_cosmosdb_account" "cosmos_db" {
  name                = "cosmosdb-${var.website_name}-exp-${var.location}"
  location            = var.location
  resource_group_name = var.rg
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  capabilities {
    name = "EnableGremlin"
  }

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  enable_automatic_failover       = true
  enable_multiple_write_locations = true

  tags = var.tags
}

resource "azurerm_cosmosdb_gremlin_database" "gremlin_db" {
  name                = "gremlindb-${var.website_name}-exp-${var.location}"
  resource_group_name = var.rg
  account_name        = azurerm_cosmosdb_account.cosmos_db.name
}

resource "azurerm_cosmosdb_gremlin_graph" "gremlin_graph" {
  name                = "example-gremlin-graph"
  resource_group_name = var.rg
  account_name        = azurerm_cosmosdb_account.cosmos_db.name
  database_name       = azurerm_cosmosdb_gremlin_database.gremlin_db.name
  throughput          = 400
  partition_key_path = "/pk"
  partition_key_version = 1

  index_policy {
    automatic      = true
    indexing_mode  = "consistent"
    included_paths = ["/*"]
    excluded_paths = ["/\"_etag\"/?"]
  }

  conflict_resolution_policy {
    mode                     = "LastWriterWins"
    conflict_resolution_path = "/_ts"
  }

  unique_key {
    paths = ["/definition/id1", "/definition/id2"]
  }
}