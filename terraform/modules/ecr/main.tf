resource "aws_ecr_repository" "threatcomposer_ecr_repo" {
  name                 = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  tags = {
    Name = var.repository_name
  }
}