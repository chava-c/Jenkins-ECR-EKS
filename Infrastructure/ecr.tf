resource "aws_ecr_repository" "pipeline-repository" {
  name                 = "pipeline-repository"
  image_tag_mutability = "MUTABLE"
  tags = {
    Name = "Demo-repo"
    Owner = "scardenas"
    PRoject = "DevOps-Internship"
  }
}

resource "aws_ecr_repository_policy" "pipeline-repo-policy" {
  repository = aws_ecr_repository.pipeline-repository.name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the demo repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}