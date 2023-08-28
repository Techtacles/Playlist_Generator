variable "aws_region" {
  type = string

}




###### API GATEWAY ######
variable "api_gw_stage_name" {
  type = string

}

variable "api_gw_name" {
  type = string

}

variable "api_gw_path" {
  type = string

}

variable "api_gw_http_method" {
  type = string

}

variable "api_gw_integration_type" {
  type = string

}

###### ECR #######
variable "ecr_name" {
  type = string

}
variable "ecr_force_delete" {
  type = bool

}
variable "scan_on_push" {
  type = bool

}

####### LAMBDA ########
variable "lambda_role" {
  type = string

}
variable "lambda_src_file_path" {
  type = string

}



variable "lambda_fn_name" {
  type = string

}

variable "lambda_handler" {
  type = string

}
variable "lambda_runtime" {
  type = string

}
variable "lambda_timeout" {
  type = number

}

variable "lambda_memory_size" {
  type = number

}




