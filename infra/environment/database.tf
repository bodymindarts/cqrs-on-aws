resource "aws_dynamodb_table" "events" {
  name           = "EventStore"
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
    Name        = "events"
    Environment = "${var.environment}"
  }
}
