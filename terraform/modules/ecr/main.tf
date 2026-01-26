resource "aws_ecr_repository" "threatcomposer_ecr_repo" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  encryption_configuration {
    encryption_type = "KMS"
  }

      image_scanning_configuration {
        scan_on_push = true
      }

  tags = {
    Name = var.repository_name
  }
}
