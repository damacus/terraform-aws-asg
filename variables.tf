variable "vpc_id" {}
variable "owner" {}
variable "environment" {}
variable "application" {}
variable "name" {}

variable "description" {
  default = "AutoScalling Group"
}

variable "ami" {}

variable "instance_type" {
  default = "t2.medium"
}

variable "user_data_script" {}

# ASG
variable "asg_min_size" {}

variable "asg_max_size" {}
variable "asg_desired_capacity" {}

variable "enabled_metrics" {
  type    = "list"
  default = ["GroupTerminatingInstances", "GroupMaxSize", "GroupDesiredCapacity", "GroupPendingInstances", "GroupInServiceInstances", "GroupMinSize", "GroupTotalInstances"]
}

variable "asg_termination_policies" {
  type        = "list"
  default     = ["OldestLaunchConfiguration", "ClosestToNextInstanceHour"]
  description = "A list of policies to decide how the instances in the auto scale group should be terminated"
}

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

variable "asg_desired_capacity" {}
variable "load_balancers" {}

variable "schedule_recurrence_down" {
  default = "* 20 * * 1-5"
}

# Security
variable "security_groups" {
  type = "list"
}

variable "instance_profile" {
  default = ""
}

# Tagging
variable "email" {
  default = ""
}

variable "zones" {}
variable "cost_code" {}
