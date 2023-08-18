resource "aws_cloud9_environment_ec2" "cloud9_instance_2" {
  name                        = "cloud9_instance_2"
  instance_type               = "t2.micro"
  automatic_stop_time_minutes = 30

  tags = {
    Project   = "Hackathon"
    Terraform = "true"
  }
}
