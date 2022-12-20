resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = var.lock_table_name

  read_capacity  = local.dynamo.RCU
  write_capacity = local.dynamo.WCU

  hash_key = local.dynamo.hash_key

  attribute {
    name = local.dynamo.hash_key
    type = "S"
  }
}
