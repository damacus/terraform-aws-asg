data "availability_zones" "available" {}

data "aws_availability_zones" "available" {
  state = "available"
}
