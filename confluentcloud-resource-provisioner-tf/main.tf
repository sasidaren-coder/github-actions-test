terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.25.0"
    }
  }
}

provider "confluent" {
  alias               = "cc"
  cloud_api_key       = var.confluent_cloud_api_key
  cloud_api_secret    = var.confluent_cloud_api_secret
  kafka_id            = var.kafka_cluster_id
  kafka_rest_endpoint = var.kafka_rest_endpoint
  kafka_api_key       = var.kafka_api_key
  kafka_api_secret    = var.kafka_api_secret
}

# locals {
#   resource_config = yamldecode(file("${path.module}/resources.yaml"))
# }

locals {
  resource_config = yamldecode(file(var.resource_yaml_path))
}

module "topics" {
  source = "./modules/kafka-topic"

  providers = {
    confluent = confluent.cc
  }

  topics = local.resource_config.topics
}


module "service_accounts" {
  source = "./modules/kafka-serviceaccounts"

  providers = {
    confluent = confluent.cc
  }

  serviceaccounts = local.resource_config.serviceaccounts
  kafka_cluster_id = var.kafka_cluster_id
  cc_environment_id = var.cc_environment_id
}
