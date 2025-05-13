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
}

module "topics_azure" {
  count = var.cloud_provider == "azure" ? 1 : 0

  source = "./modules/kafka-topic"

  providers = {
    confluent = confluent.azure
  }

  topics = local.resource_config.topics
}

module "topics_gcp" {
  count = var.cloud_provider == "gcp" ? 1 : 0

  source = "./modules/kafka-topic"

  providers = {
    confluent = confluent.gcp
  }

  topics = local.resource_config.topics
}

module "topics_aws" {
  count = var.cloud_provider == "aws" ? 1 : 0

  source = "./modules/kafka-topic"

  providers = {
    confluent = confluent.aws
  }

  topics = local.resource_config.topics
}


module "service_accounts_azure" {
  count = var.cloud_provider == "azure" ? 1 : 0

  source = "./modules/kafka-serviceaccounts"

  providers = {
    confluent = confluent.azure
  }

  serviceaccounts   = local.resource_config.serviceaccounts
  kafka_cluster_id  = var.azure_kafka_cluster_id
  cc_environment_id = var.azure_cc_environment_id
}

module "service_accounts_gcp" {
  count = var.cloud_provider == "gcp" ? 1 : 0

  source = "./modules/kafka-serviceaccounts"

  providers = {
    confluent = confluent.gcp
  }

  serviceaccounts   = local.resource_config.serviceaccounts
  kafka_cluster_id  = var.gcp_kafka_cluster_id
  cc_environment_id = var.gcp_cc_environment_id
}

module "service_accounts_aws" {
  count = var.cloud_provider == "aws" ? 1 : 0

  source = "./modules/kafka-serviceaccounts"

  providers = {
    confluent = confluent.aws
  }

  serviceaccounts   = local.resource_config.serviceaccounts
  kafka_cluster_id  = var.aws_kafka_cluster_id
  cc_environment_id = var.aws_cc_environment_id
}

output "state_version" {
  value = var.state_version
  description = "Metadata version of this terraform state"
}
