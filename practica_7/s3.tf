resource "aws_s3_bucket" "ceberus_bucket" {
  bucket = local.s3-sufix
}