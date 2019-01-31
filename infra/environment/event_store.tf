resource "aws_dynamodb_table" "events" {
  name         = "${local.env_prefix}EventStore"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "AggregateId"
  range_key    = "EventCounter"

  attribute {
    name = "AggregateId"
    type = "S"
  }

  attribute {
    name = "EventCounter"
    type = "S"
  }

  tags = {
    Environment = "${var.environment}"
  }
}
