variable "keybase_account" { default = "jcarter" }

provider "aws" {
  region = "eu-central-1"
}

data "aws_iam_policy_document" "create_dynamodb_json" {
  statement {
    actions = [
      "dynamodb:*",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "create_dynamodb" {
  name   = "create-dynamodb"
  path   = "/"
  policy = "${data.aws_iam_policy_document.create_dynamodb_json.json}"
}

resource "aws_iam_user" "prod_setup" {
  name = "prod-setup"
}

resource "aws_iam_user_policy_attachment" "prod_create_dynamodb" {
  user       = "${aws_iam_user.prod_setup.name}"
  policy_arn = "${aws_iam_policy.create_dynamodb.arn}"
}

resource "aws_iam_access_key" "prod_setup_key" {
  user    = "${aws_iam_user.prod_setup.name}"
  pgp_key = "keybase:${var.keybase_account}"
}

output "prod_access_key" {
  value = "${aws_iam_access_key.prod_setup_key.id}"
}

output "prod_secret_key" {
  value = "${aws_iam_access_key.prod_setup_key.encrypted_secret}"
}
