variable "confluent_cloud_api_key" {
  type        = string
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  type        = string
  sensitive   = true
}

variable "kafka_cluster_id" {
  type = string
}

variable "kafka_rest_endpoint" {
  type = string
}

variable "kafka_api_key" {
  type      = string
  sensitive = true
}

variable "kafka_api_secret" {
  type      = string
  sensitive = true
}

variable "topics" {
  type = list(object({
    topic_name         = string
    partitions_count   = number
    config             = map(string)
  }))
}

variable "serviceaccounts" {
  type = list(object({
    name      = string
    description      = string
    operation = list(string)
  }))
}

