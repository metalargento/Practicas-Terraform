resource "aws_s3_bucket" "proveedores" {
  count  = 6
  bucket = "proveedores-${random_string.sufijo[count.index].id}"

}

resource "random_string" "sufijo" {
  count   = 6
  length  = 8
  upper   = false
  numeric = false
  special = false

}
