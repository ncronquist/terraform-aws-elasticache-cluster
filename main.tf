# resource "aws_elasticache_parameter_group" "redis" {
#   name   = "cache-params"
#   family = "redis2.8"
#
#   parameter {
#     name  = "activerehashing"
#     value = "yes"
#   }
#
#   parameter {
#     name  = "min-slaves-to-write"
#     value = "2"
#   }
# }

variable "subnets" {
  description = "List of subnets for the cluster subnet group"
  type        = list(string)
  // Temp-default - move to var file
  default = [
    "subnet-e1f173bc",
    "subnet-035cec7b",
    "subnet-abd00de1",
    "subnet-763b015d",
  ]
}

variable "name" {
  description = "Cluster name"
  type        = string
  // Temp-default - move to var file
  default = "terratest-cluster"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_elasticache_subnet_group" "redis" {
  name       = "tf-test-cache-subnet"
  subnet_ids = var.subnets
}

resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = var.name
  replication_group_description = "test description"
  node_type                     = "cache.t2.small"
  port                          = 6379
  parameter_group_name          = "default.redis6.x.cluster.on"
  automatic_failover_enabled    = true
  subnet_group_name             = aws_elasticache_subnet_group.redis.name

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 2
  }
}
