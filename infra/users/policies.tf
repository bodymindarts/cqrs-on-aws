data "aws_iam_policy_document" "env_policy_doc" {
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

resource "aws_iam_policy" "env_all" {
  name   = "${local.env_prefix}all"
  path   = "/"
  policy = "${data.aws_iam_policy_document.env_policy_doc.json}"
}
