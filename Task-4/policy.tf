resource "aws_iam_policy" "policy" {
  name        = "task6-policy"
  description = "task6 policy"

  policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:ListAllMyBuckets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:iam::620453548539:role/task6_role"
    }

  ]
}
EOT
}

##Attach this policy to IAM we created

resource "aws_iam_role_policy_attachment" "task6_attachment" {
  role       = aws_iam_role.task6_role.name
  policy_arn = "arn:aws:iam::620453548539:policy/task6-policy"
}