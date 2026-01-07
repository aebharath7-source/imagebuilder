# Simple version: assume the user always passes the Infrastructure Configuration ARN
# in the variable "infrastructure_configuration_identifier"

locals {
  infra_arn = var.infrastructure_configuration_identifier
}
