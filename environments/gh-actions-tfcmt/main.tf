resource "aws_s3_bucket" "tfcmt_sample" {
  bucket = "thaim-sample-tfcmt-${formatdate("YYYYMMDDhhmmss", timestamp())}"

  tags = {
    Name        = "tfcmt-sample"
    Environment = "test"
    repo        = "thaim-sandbox/sample-terraform-aws"
  }

  lifecycle {
    ignore_changes = [bucket]
  }
}

resource "aws_s3_bucket_versioning" "tfcmt_sample" {
  bucket = aws_s3_bucket.tfcmt_sample.id

  versioning_configuration {
    status = "Enabled"
  }
}

output "bucket_name" {
  value       = aws_s3_bucket.tfcmt_sample.bucket
  description = "The name of the S3 bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.tfcmt_sample.arn
  description = "The ARN of the S3 bucket"
}
