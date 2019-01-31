data "aws_iam_policy_document" "setup_env" {
  statement {
    actions = [
      "dynamodb:*",
    ]

    resources = [
      "arn:aws:dynamodb:*:*:table/${local.env_prefix}*",
    ]
  }

  statement {
    actions = [
      "iam:*",
    ]

    resources = ["arn:aws:iam::*:role/${local.env_prefix}*"]
  }

  statement {
    actions = [
      "lambda:*",
    ]

    resources = ["arn:aws:lambda:*:*:function:${local.env_prefix}*"]
  }
}

resource "aws_iam_policy" "setup_prod" {
  name   = "setup_prod"
  path   = "/"
  policy = "${data.aws_iam_policy_document.setup_env.json}"
}

resource "aws_iam_user" "prod_setup" {
  name = "prod_setup"
}

resource "aws_iam_user_policy_attachment" "setup_prod" {
  user       = "${aws_iam_user.prod_setup.name}"
  policy_arn = "${aws_iam_policy.setup_prod.arn}"
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
