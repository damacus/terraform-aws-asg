data "availability_zones" "available" {}

data "aws_ami" "ecs-optimized" {
  most_recent      = true
  executable_users = ["self"]

  filter {
    name   = "name"
    values = ["amzn-ami-2016.09.g-amazon-ecs-optimized"]
  }
}
