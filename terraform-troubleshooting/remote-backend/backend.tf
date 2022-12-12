terraform {
  backend "s3"{
    bucket                 = "<YOUR_BUCKET_NAME>"
    region                 = "<YOUR_BUCKET_REGION>"
    key                    = "backend.tfstate"
    dynamodb_table         = "<YOUR_DYNAMODB_TABLE_NAME>"
  }
}
