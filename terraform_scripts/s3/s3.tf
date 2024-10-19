resource "aws_s3_bucket" "dhruv" {
    bucket = "dhruv-casestudy"
    tags = {
        Name        = "My Bucket"
        Environment = "Dev"
    }
}

output "bucket_name" {
    value = aws_s3_bucket.dhruv.bucket  # Output the bucket name
}
