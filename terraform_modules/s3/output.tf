output "bucket_name" {
    value=aws_s3_bucket.playlist_gen_bucket.id  
}
output "bucket_arn" {
    value = aws_s3_bucket.playlist_gen_bucket.arn
  
}
