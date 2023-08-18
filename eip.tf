data "aws_instance" "cloud9_instance_2" {
  filter {
    name = "tag:aws:cloud9:environment"
    values = [
      aws_cloud9_environment_ec2.cloud9_instance_2.id,
    ]
  }
}

# Create elastic ip
resource "aws_eip" "cloud9_eip" {
  instance = data.aws_instance.cloud9_instance_2.id
  domain   = "vpc"
}
