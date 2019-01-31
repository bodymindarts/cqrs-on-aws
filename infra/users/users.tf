resource "aws_iam_user" "setup" {
  name = "${local.env_prefix}setup"
}

resource "aws_iam_user_policy_attachment" "setup_policy" {
  user       = "${aws_iam_user.setup.name}"
  policy_arn = "${aws_iam_policy.env_all.arn}"
}

resource "aws_iam_access_key" "setup_key" {
  user    = "${aws_iam_user.setup.name}"
  pgp_key = "keybase:${var.keybase_account}"
}

output "prod_access_key" {
  value = "${aws_iam_access_key.setup_key.id}"
}

output "prod_secret_key" {
  value = "${aws_iam_access_key.setup_key.encrypted_secret}"
}
