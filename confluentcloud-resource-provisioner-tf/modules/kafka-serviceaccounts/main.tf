terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
    }
  }
}

resource "confluent_service_account" "this" {
  for_each = { for sa in var.serviceaccounts : sa.name => sa }

  provider = confluent
  display_name = each.value.name
  description  = each.value.description
}

resource "confluent_api_key" "this" {
  for_each = confluent_service_account.this
  
  provider = confluent
  display_name = "API Key for ${each.value.display_name}"
  description  = "API Key for ${each.value.description}"
  owner {
    id          = each.value.id
    api_version = each.value.api_version
    kind        = each.value.kind
  }

  managed_resource {
    id          = var.kafka_cluster_id
    api_version = "cmk/v2"
    kind        = "Cluster"
  }

  depends_on = [confluent_service_account.this]
}