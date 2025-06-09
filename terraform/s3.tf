resource "aws_s3_bucket" "data_bucket" {
  bucket = "my-etl-data-bucket-${random_id.bucket_id.hex}"
}

resource "random_id" "bucket_id" {
  byte_length = 4
}
