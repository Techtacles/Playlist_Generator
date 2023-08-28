data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com","apigateway.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = var.lambda_role
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.lambda_src_file_path
  output_path = var.lambda_output_zip
}
