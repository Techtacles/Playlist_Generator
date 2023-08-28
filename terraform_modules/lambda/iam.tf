

resource "aws_iam_role" "iam_for_lambda" {
  name = var.lambda_role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "apigateway.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy" "lambda_policy" {
  name = "playlist_gen_iam_policy"
  role = aws_iam_role.iam_for_lambda.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "lambda:*",
          "s3:*",
          "ecr:*",
          "events:*",
          "apigateway:*"

        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
