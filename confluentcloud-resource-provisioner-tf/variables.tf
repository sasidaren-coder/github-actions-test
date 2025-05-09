# Azure
variable "azure_confluent_cloud_api_key" {
  type        = string
  sensitive   = true
}

variable "azure_confluent_cloud_api_secret" {
  type        = string
  sensitive   = true
}

variable "azure_kafka_cluster_id" {
  type = string
}

variable "azure_kafka_rest_endpoint" {
  type = string
}

variable "azure_kafka_api_key" {
  type      = string
  sensitive = true
}

variable "azure_kafka_api_secret" {
  type      = string
  sensitive = true
}

variable "azure_cc_environment_id" {
  type = string
}

## GCP
variable "gcp_confluent_cloud_api_key" {
  type        = string
  sensitive   = true
}

variable "gcp_confluent_cloud_api_secret" {
  type        = string
  sensitive   = true
}

variable "gcp_kafka_cluster_id" {
  type = string
}

variable "gcp_kafka_rest_endpoint" {
  type = string
}

variable "gcp_kafka_api_key" {
  type      = string
  sensitive = true
}

variable "gcp_kafka_api_secret" {
  type      = string
  sensitive = true
}

variable "gcp_cc_environment_id" {
  type = string
}

## AWS
variable "aws_confluent_cloud_api_key" {
  type        = string
  sensitive   = true
}

variable "aws_confluent_cloud_api_secret" {
  type        = string
  sensitive   = true
}

variable "aws_kafka_cluster_id" {
  type = string
}

variable "aws_kafka_rest_endpoint" {
  type = string
}

variable "aws_kafka_api_key" {
  type      = string
  sensitive = true
}

variable "aws_kafka_api_secret" {
  type      = string
  sensitive = true
}

variable "aws_cc_environment_id" {
  type = string
}

variable "cloud_provider" {
  type = string
}

# Resource Configs
variable "resource_yaml_path" {
  type        = string
  description = "Path to the YAML config file"
}


