variable "environment" {}

locals {
  env_prefix = "${var.environment}_"
}
