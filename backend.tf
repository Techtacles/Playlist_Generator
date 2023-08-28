terraform {
  backend "s3" {
    bucket = var.bucket_name
    key    = var.backend_key
    region = var.aws_region
  }
}
