output "lambda_arn" {
    value = aws_lambda_function.lambda_fn.arn
}
output "lambda_invoke_arn" {
    value = aws_lambda_function.lambda_fn.invoke_arn
  
}
