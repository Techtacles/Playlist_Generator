resource "aws_ecr_repository" "playlist_gen_ecr" {
  name         = var.ecr_name
  force_delete = var.ecr_force_delete

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}

data "aws_ecr_image" "service_image" {
  repository_name = var.ecr_name
  image_tag       = "latest"
}
