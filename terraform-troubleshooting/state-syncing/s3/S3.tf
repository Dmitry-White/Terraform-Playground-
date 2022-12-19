provider "aws" {
  region     = "us-east-1"
}

resource "aws_s3_bucket" "justice_league" {
    bucket = "hall-of-buckets1kjdhgsd"
}

resource "aws_s3_bucket_acl" "justice_league_acl" {
  bucket = aws_s3_bucket.justice_league.id
  acl    = "private"
}
