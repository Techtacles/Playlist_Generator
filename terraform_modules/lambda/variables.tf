variable "lambda_role" {
  type = string

}
variable "lambda_src_file_path" {
  type = string

}



variable "lambda_fn_name" {
  type = string

}

/* variable "lambda_handler" {
  type = string

}
variable "lambda_runtime" {
  type = string

} */
variable "lambda_timeout" {
  type = number

}

variable "api_gw_exec_arn" {
  type = string

}

variable "lambda_memory_size" {
  type = number

}

variable "ecr_image_uri" {
  type = string

}
variable "ecr_sha" {
  type = string

}
