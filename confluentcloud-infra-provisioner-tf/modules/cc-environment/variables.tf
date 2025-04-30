variable "topics" {
  type = list(object({
    topic_name         = string
    partitions_count   = number
    config             = map(string)
  }))
}
