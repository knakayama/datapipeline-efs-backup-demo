resource "random_id" "s3" {
  byte_length = 8

  keepers = {
    name = "${var.name}"
  }
}

resource "aws_s3_bucket" "s3" {
  bucket        = "${random_id.s3.hex}"
  force_destroy = true
}
