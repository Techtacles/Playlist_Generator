output "ecr_arn" {
    value = aws_ecr_repository.playlist_gen_ecr.arn
  
}

output "ecr_repo_url" {
    value = aws_ecr_repository.playlist_gen_ecr.repository_url
  
}
