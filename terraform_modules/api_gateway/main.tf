resource "aws_api_gateway_rest_api" "api_gw_rest" {
  name = var.api_gw_name
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "api_gw_resource" {
  parent_id   = aws_api_gateway_rest_api.api_gw_rest.root_resource_id
  path_part   = var.api_gw_path
  rest_api_id = aws_api_gateway_rest_api.api_gw_rest.id
}

resource "aws_api_gateway_method" "api_gw_method" {
  authorization = "NONE"
  http_method   = var.api_gw_http_method
  resource_id   = aws_api_gateway_resource.api_gw_resource.id
  rest_api_id   = aws_api_gateway_rest_api.api_gw_rest.id
}

resource "aws_api_gateway_integration" "api_gw_integration" {
  http_method             = aws_api_gateway_method.api_gw_method.http_method
  resource_id             = aws_api_gateway_resource.api_gw_resource.id
  rest_api_id             = aws_api_gateway_rest_api.api_gw_rest.id
  type                    = var.api_gw_integration_type
  uri                     = var.lambda_invoke_url
  integration_http_method = "POST"
}

resource "aws_api_gateway_deployment" "api_gw_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api_gw_rest.id

  triggers = {
    # NOTE: The configuration below will satisfy ordering considerations,
    #       but not pick up all future REST API changes. More advanced patterns
    #       are possible, such as using the filesha1() function against the
    #       Terraform configuration file(s) or removing the .id references to
    #       calculate a hash against whole resources. Be aware that using whole
    #       resources will show a difference after the initial implementation.
    #       It will stabilize to only change when resources change afterwards.
    redeployment = sha1(jsonencode([
      aws_api_gateway_resource.api_gw_resource.id,
      aws_api_gateway_method.api_gw_method.id,
      aws_api_gateway_integration.api_gw_integration.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_gw_stage" {
  deployment_id = aws_api_gateway_deployment.api_gw_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.api_gw_rest.id
  stage_name    = var.api_gw_stage_name
}

###ENABLE CORS
resource "aws_api_gateway_method" "options" {
  rest_api_id   = aws_api_gateway_rest_api.api_gw_rest.id
  resource_id   = aws_api_gateway_resource.api_gw_resource.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_method_response" "options_200" {
  rest_api_id = aws_api_gateway_rest_api.api_gw_rest.id
  resource_id = aws_api_gateway_resource.api_gw_resource.id
  http_method = aws_api_gateway_method.options.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Headers" = true
  }
}

resource "aws_api_gateway_integration" "options_integration" {
  http_method             = aws_api_gateway_method.api_gw_method.http_method
  resource_id             = aws_api_gateway_resource.api_gw_resource.id
  rest_api_id             = aws_api_gateway_rest_api.api_gw_rest.id
  type                    = "MOCK"
  integration_http_method = "POST"
}
