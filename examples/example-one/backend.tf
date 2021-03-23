terraform {
  backend "s3" {
    bucket = "terraform-testing-state-ncronquist"
    key    = "terratest/terraform-aws-elasticache-cluster/examples/example-one"
    region = "us-west-2"
  }
}
