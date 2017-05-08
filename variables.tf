variable "vpc_id" {}
variable "owner" {}
variable "environment" {}
variable "application" {}
variable "name" {}
variable "description" {
  default = "AutoScalling Group"
}
variable "image_id" {}

# ASG Schedule
variable "asg_min_size_up" {}
variable "asg_max_size_up" {}
variable "asg_desired_capacity_up" {}
variable "schedule_recurrence_up" {
  default = "* 6 * * 1-5"
}
variable "asg_min_size_down" {}
variable "asg_max_size_down" {}
variable "asg_desired_capacity_down" {}
variable "schedule_recurrence_down" {
  default = "* 20 * * 1-5"
}

variable "security_groups" {
  type = "list"
}

variable "instance_profile" {
  default = ""
}
