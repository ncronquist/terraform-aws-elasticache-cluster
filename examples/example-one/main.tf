provider "aws" {
  region = "us-west-2"
}

module "elasticache_cluster" {
  source = "../../"
}
