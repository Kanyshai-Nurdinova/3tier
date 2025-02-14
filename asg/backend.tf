resource "aws_s3_bucket" "my_bucket" {
bucket = "bucket-terraform-${random_string.random.result}"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.id
}