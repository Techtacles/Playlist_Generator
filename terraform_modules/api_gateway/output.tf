output "api_gw_arn" {
    value = aws_api_gateway_rest_api.api_gw_rest.arn
  
}

output "api_gw_lambda_exec_arn" {
    value = aws_api_gateway_rest_api.api_gw_rest.execution_arn
  
}

output "api_gw_id" {
    value = aws_api_gateway_rest_api.api_gw_rest.id
  
}
