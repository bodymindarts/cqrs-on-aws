variable function_name {
  default = "hello_world"
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "${local.env_prefix}fn_${var.function_name}_role"

  assume_role_policy = "${data.aws_iam_policy_document.lambda_assume_role.json}"
}

resource "aws_lambda_function" "hello_world" {
  filename         = "tmp/lambda/${var.function_name}.zip"
  function_name    = "${local.env_prefix}${var.function_name}"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "index.handler"
  source_code_hash = "${base64sha256(file("tmp/lambda/${var.function_name}.zip"))}"
  runtime          = "nodejs8.10"
}
