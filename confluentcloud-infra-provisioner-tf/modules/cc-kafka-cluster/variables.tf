variable "serviceaccounts" {
  type = list(object({
    name      = string
    description      = string
    operation = list(string)
  }))
}

variable "kafka_cluster_id" {
  type = string
}

variable "cc_environment_id" {
  type = string
}