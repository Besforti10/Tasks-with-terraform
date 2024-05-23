resource "aws_dynamodb_table" "besfort_table" {
  name           = "besfort-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}


resource "aws_dynamodb_table" "besfort_table2" {
  name           = "besfort-table2"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
