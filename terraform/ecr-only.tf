resource "aws_ecr_repository" "frontend_repo" {
  name = "hydrus-frontend"
  tags = {
    project = "hydrus"
  }
}

resource "aws_ecr_repository" "backend_repo" {
  name = "hydrus-backend"
  tags = {
    project = "hydrus"
  }
}
