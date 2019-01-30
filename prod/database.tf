provider "aws" {
  alias = "prod_setup"
  region = "eu-central-1"
}

resource "aws_dynamodb_table" "aggregates" {
  provider = "aws.prod_setup"

  name           = "Aggregates"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "AggregateId"
  range_key      = "EventCounter"

  attribute {
    name = "AggregateId"
    type = "S"
  }

  attribute {
    name = "EventCounter"
    type = "S"
  }

  tags = {
    Name        = "aggregates"
    Environment = "production"
  }
}
