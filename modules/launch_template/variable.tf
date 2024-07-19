variable "instance_type" {
  description = "Here we will use for ec2 instance type creation"
  type = string
}
variable "key_name" {
  default     = "karan"  # Default value, can be overridden
}
variable "launch_template_id_source" {
  description = "ID of the launch template to use"
  type        = string  // Adjust type according to the actual output type
}
variable "aws_ecs_policy" {
    type        = string

}