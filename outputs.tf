output "cloud9_url" {
  value = "https://${var.aws_region}.console.aws.amazon.com/cloud9/ide/${aws_cloud9_environment_ec2.cloud9_instance_2.id}"
}

output "hackathon_user_1_arn" {
  value = aws_iam_user.hackathon_user_1.arn
}

output "hackathon_user_1_password" {
  value = aws_iam_user_login_profile.hackathon_user_1.password
}
