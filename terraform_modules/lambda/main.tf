resource "aws_lambda_function" "lambda_fn" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  function_name = var.lambda_fn_name
  role          = aws_iam_role.iam_for_lambda.arn
  #handler       = var.lambda_handler

  #source_code_hash = data.archive_file.lambda.output_base64sha256

  #runtime = var.lambda_runtime

  timeout      = var.lambda_timeout
  memory_size  = var.lambda_memory_size
  image_uri    = "${var.ecr_image_uri}@${var.ecr_sha}"
  package_type = "Image"


  environment {
    variables = {
      HF_HOME            = "/tmp",
      TRANSFORMERS_CACHE = "/tmp",
      XDG_CACHE_HOME     = "/tmp"
    }
  }
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowPlaylistGenLambdaInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_fn_name
  principal     = "apigateway.amazonaws.com"

  # The /* part allows invocation from any stage, method and resource path
  # within API Gateway.
  source_arn = "${var.api_gw_exec_arn}/*"
}
