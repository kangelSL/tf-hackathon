resource "aws_iam_user" "hackathon_user_1" {
  name          = "hackathon_user_1"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "hackathon_user_1" {
  user = aws_iam_user.hackathon_user_1.name
}

resource "aws_cloud9_environment_membership" "hackathon_user_1_membership" {
  environment_id = aws_cloud9_environment_ec2.cloud9_instance_2.id
  permissions    = "read-write"
  user_arn       = aws_iam_user.hackathon_user_1.arn
}

resource "aws_iam_user_policy" "cloud_9_policy" {
 name = "AWSCloud9EnvironmentMember"
 user = aws_iam_user.hackathon_user_1.name

 policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "cloud9:GetUserSettings",
                "cloud9:UpdateUserSettings",
                "iam:GetUser",
                "iam:ListUsers"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloud9:DescribeEnvironmentMemberships"
            ],
            "Resource": [
                "*"
            ],
            "Condition": {
                "Null": {
                    "cloud9:UserArn": "true",
                    "cloud9:EnvironmentId": "true"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": "ssm:StartSession",
            "Resource": "arn:aws:ec2:*:*:instance/*",
            "Condition": {
                "StringLike": {
                    "ssm:resourceTag/aws:cloud9:environment": "*"
                },
                "StringEquals": {
                    "aws:CalledViaFirst": "cloud9.amazonaws.com"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:StartSession"
            ],
            "Resource": [
                "arn:aws:ssm:*:*:document/*"
            ]
        }
    ]
}
 EOF
}