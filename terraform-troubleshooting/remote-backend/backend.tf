# Each terraform block can contain a number of settings
# related to Terraform's behavior. 
# Within a terraform block, only constant values can be used;
# arguments may not refer to named objects such as 
# resources, input variables, etc,
# and may not use any of the Terraform language built-in functions.
terraform {
  backend "s3" {
    key            = "backend.tfstate"
    region         = "<AWS_REGION>"
    bucket         = "<YOUR_BUCKET_NAME>"
    dynamodb_table = "<YOUR_DYNAMODB_TABLE_NAME>"
  }
}
