resource "aws_s3_bucket" "besfort_bucket" {
  bucket = "besfort-task1-bucket"
  tags = {
    Name = "besfort-task1-bucket"
  }
  versioning {
    enabled = true
  }
}
resource "aws_s3_bucket" "besfort_bucket2" {
  bucket = "besfort-task1-bucket2"
  tags = {
    Name = "besfort-task1-bucket2"
  }
  versioning {
    enabled = true
  }
}
resource "aws_s3_bucket_replication_configuration" "replication" {
  bucket = aws_s3_bucket.besfort_bucket.id
  role   = "arn:aws:iam::620453548539:role/S3-Replication-Role"

  rule {
    id     = "replication-rule"
    status = "Enabled"

    destination {
      bucket        = "arn:aws:s3:::besfort-task1-bucket2"
      storage_class = "STANDARD"
    }
  }
}
resource "aws_iam_role" "s3_replication_role" {
  name = "s3_replication_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "s3.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "s3_replication_policy" {
  role = aws_iam_role.s3_replication_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObjectVersionForReplication",
          "s3:GetObjectVersionAcl",
          "s3:GetObjectVersionTagging",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.besfort_bucket.arn,
          "${aws_s3_bucket.besfort_bucket.arn}/*"
        ]
      },
      {
        Effect   = "Allow",
        Action   = [
          "s3:ReplicateObject",
          "s3:ReplicateDelete",
          "s3:ReplicateTags"
        ],
        Resource = [
          aws_s3_bucket.besfort_bucket2.arn,
          "${aws_s3_bucket.besfort_bucket2.arn}/*"
        ]
      }
    ]
  })
}