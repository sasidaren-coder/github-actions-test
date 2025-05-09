terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.25.0"
    }
  }
}

provider "confluent" {
  alias               = "azure"
  cloud_api_key       = var.azure_confluent_cloud_api_key
  cloud_api_secret    = var.azure_confluent_cloud_api_secret
  kafka_id            = var.azure_kafka_cluster_id
  kafka_rest_endpoint = var.azure_kafka_rest_endpoint
  kafka_api_key       = var.azure_kafka_api_key
  kafka_api_secret    = var.azure_kafka_api_secret
}

provider "confluent" {
  alias               = "gcp"
  cloud_api_key       = var.gcp_confluent_cloud_api_key
  cloud_api_secret    = var.gcp_confluent_cloud_api_secret
  kafka_id            = var.gcp_kafka_cluster_id
  kafka_rest_endpoint = var.gcp_kafka_rest_endpoint
  kafka_api_key       = var.gcp_kafka_api_key
  kafka_api_secret    = var.gcp_kafka_api_secret
}

provider "confluent" {
  alias               = "aws"
  cloud_api_key       = var.aws_confluent_cloud_api_key
  cloud_api_secret    = var.aws_confluent_cloud_api_secret
  kafka_id            = var.aws_kafka_cluster_id
  kafka_rest_endpoint = var.aws_kafka_rest_endpoint
  kafka_api_key       = var.aws_kafka_api_key
  kafka_api_secret    = var.aws_kafka_api_secret
}

locals {
  resource_config = yamldecode(file(var.resource_yaml_path))
  cloud_provider  = var.cloud_provider
  active_aliases = {
    azure = var.cloud_provider == "azure"
    gcp   = var.cloud_provider == "gcp"
    aws   = var.cloud_provider == "aws"
  }
}

module "topics" {
  for_each = { for k, v in local.active_aliases : k => v if v }

  source = "./modules/kafka-topic"

  providers = {
    confluent = confluent.azure
    confluent = confluent.gcp
    confluent = confluent.aws
  }[each.key]

  topics = local.resource_config.topics
}

module "service_accounts" {
  for_each = { for k, v in local.active_aliases : k => v if v }

  source = "./modules/kafka-serviceaccounts"

  providers = {
    confluent = confluent.azure
    confluent = confluent.gcp
    confluent = confluent.aws
  }[each.key]

  serviceaccounts = local.resource_config.serviceaccounts

  kafka_cluster_id = lookup({
    azure = var.azure_kafka_cluster_id,
    gcp   = var.gcp_kafka_cluster_id,
    aws   = var.aws_kafka_cluster_id
  }, each.key)

  cc_environment_id = lookup({
    azure = var.azure_cc_environment_id,
    gcp   = var.gcp_cc_environment_id,
    aws   = var.aws_cc_environment_id
  }, each.key)
}