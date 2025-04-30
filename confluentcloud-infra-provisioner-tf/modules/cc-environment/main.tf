terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
    }
  }
}

resource "confluent_kafka_topic" "this" {
  for_each = { for topic in var.topics : topic.topic_name => topic }

  provider           = confluent
  topic_name         = each.value.topic_name
  partitions_count   = each.value.partitions_count
  config             = each.value.config

#   lifecycle {
#     prevent_destroy = true
#   }
}
