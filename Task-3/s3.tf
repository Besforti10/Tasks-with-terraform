resource "aws_s3_bucket" "besfort_bucket" {
  bucket = "besfort-bucket"
  acl    = "private"
  versioning {
    enabled = true
  }
  lifecycle_rule {
    id      = "s3-lifecycle-rule"
    enabled = true
    noncurrent_version_expiration {
      days = 30
    }
    expiration {
      days = 365
    }
  }
  tags = {
    Name = "besfort-bucket"
  }
}
