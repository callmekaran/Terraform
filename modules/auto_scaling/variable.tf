variable "launch_template_id_source" {
  description = "ID of the launch template to use"
  type        = string  // Adjust type according to the actual output type
}

variable "auto_scaling_arn" {
  type        = string
}