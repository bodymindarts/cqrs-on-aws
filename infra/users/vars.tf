variable "keybase_account" {
  default = "jcarter"
}

variable "environment" {
  default = "PROD"
}

locals {
  env_prefix = "${var.environment}_"
}
