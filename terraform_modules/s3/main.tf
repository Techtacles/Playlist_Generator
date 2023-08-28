resource "aws_s3_bucket" "playlist_gen_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_tag
    Environment = var.bucket_env
  }
}
