resource "aws_s3_bucket" "my_bucket" {
  bucket = "bucket-terraform-${random_string.random.result}"  # Replace with a globally unique name

  tags = {
    Name        = "MyS3Bucket"
    Environment = "Dev"
  }
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}


resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.id
}

resource "local_file" "s3_bucket_name" {
  filename = "s3_bucket.txt"
  content  = aws_s3_bucket.my_bucket.id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}