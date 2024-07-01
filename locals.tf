locals {
  tags = {
    Client      = "OCC"
    Environment = "Dev"
  }
  stgname = random_string.random.result
}

resource "random_string" "random" {
  length  = 16
  special = false
  upper   = false
}