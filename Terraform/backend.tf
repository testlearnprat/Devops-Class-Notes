provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "s3bucket-for-backend" {
  bucket = "s3bucket-for-backend-123987"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3bucket-for-backend.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "dynamodb-for-backend" {
  name             = "dynamodb-for-backend"
  billing_mode     = "PROVISIONED"
  read_capacity    = 10
  write_capacity   = 10
  hash_key         = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


