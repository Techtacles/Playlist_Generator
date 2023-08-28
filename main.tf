module "api_gw" {
  source                  = "./terraform_modules/api_gateway"
  api_gw_name             = var.api_gw_name
  api_gw_stage_name       = var.api_gw_stage_name
  api_gw_path             = var.api_gw_path
  api_gw_http_method      = var.api_gw_http_method
  api_gw_integration_type = var.api_gw_integration_type


}

module "ecr" {
  source           = "./terraform_modules/ecr"
  ecr_name         = var.ecr_name
  ecr_force_delete = var.ecr_force_delete
  scan_on_push     = var.scan_on_push


}

module "lambda" {
  source               = "./terraform_modules/lambda"
  lambda_role          = var.lambda_role
  lambda_src_file_path = var.lambda_src_file_path
  lambda_fn_name       = var.lambda_fn_name
  lambda_handler       = var.lambda_handler
  lambda_runtime       = var.lambda_runtime
  lambda_timeout       = var.lambda_timeout
  api_gw_exec_arn      = module.api_gw.api_gw_lambda_exec_arn
  lambda_memory_size   = var.lambda_memory_size
  ecr_image_uri        = module.ecr.ecr_arn


}
