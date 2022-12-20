resource "aws_s3_bucket" "justice_league" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "justice_league_acl" {
  bucket = aws_s3_bucket.justice_league.id
  acl    = "private"
}
