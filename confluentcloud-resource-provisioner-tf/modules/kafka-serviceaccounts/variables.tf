variable "serviceaccounts" {
  type = list(object({
    name      = string
    description      = string
  }))
}

variable "kafka_cluster_id" {
  type = string
}

variable "cc_environment_id" {
  type = string
}