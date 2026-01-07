variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region where Image Builder resources will be created."
}

variable "base_ami_id" {
  type        = string
  description = "Base AMI ID to use as parent_image (e.g. ami-0abcd1234)."
}

variable "component_arn" {
  type        = string
  description = "ARN of an existing Image Builder component in your account (component must exist)."
}

variable "infrastructure_configuration_identifier" {
  type        = string
  description = <<-EOT
  Either the ARN or the name of an existing Image Builder Infrastructure Configuration.
  The configuration will be looked up automatically by checking if the value starts with 'arn:'.
  EOT
}

variable "organization_arn" {
  type        = string
  description = "AWS Organization ARN to grant launch permission in the distribution (e.g. arn:aws:organizations::123456789012:organization/o-xxxx)."
}

variable "pipeline_name" {
  type    = string
  default = "my-image-pipeline"
}

variable "recipe_name" {
  type    = string
  default = "my-image-recipe"
}

variable "distribution_name" {
  type    = string
  default = "my-distribution-config"
}

variable "ami_output_name" {
  description = "The AMI output name to assign in the distribution (in us-east-1)"
  type        = string

  # Must include {{imagebuilder:buildDate}} so AWS accepts it
  default     = "company-golden-ami-{{imagebuilder:buildDate}}-{{imagebuilder:buildVersion}}"
}
