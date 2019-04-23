variable "vpc_id" {}

variable "security_groups" {
  type    = "list"
  default = []
}

variable "instance_profile" {
  default = ""
}

variable "name" {}

variable "instance_type" {
  default = "t2.large"
}

# ASG
variable "user_data_script" {}

variable "load_balancers" {
  default = ""
}

variable "subnets" {
  type = "list"
}

variable "enabled_metrics" {
  type = "list"

  default = [
    "GroupTerminatingInstances",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupPendingInstances",
    "GroupInServiceInstances",
    "GroupMinSize",
    "GroupTotalInstances",
  ]
}

variable "termination_policies" {
  type        = "list"
  default     = ["OldestLaunchConfiguration", "ClosestToNextInstanceHour"]
  description = "A list of policies to decide how the instances in the auto scale group should be terminated"
}

variable "health_check_type" {
  default = "EC2"
}

variable "health_check_grace_period" {
  default = "300"
}

variable "map_public_ip" {
  default = false
}

variable "key_name" {
  default = ""
}

## AutoScalling
variable "asg_min_size" {}

variable "asg_max_size" {}
variable "asg_desired_capacity" {}
variable "asg_min_size_up" {}
variable "asg_max_size_up" {}
variable "asg_desired_capacity_up" {}
variable "asg_min_size_down" {}
variable "asg_max_size_down" {}
variable "asg_desired_capacity_down" {}

variable "schedule_recurrence_up" {
  default = "* 6 * * 1-5"
}

variable "schedule_recurrence_down" {
  default = "* 20 * * 1-5"
}

## Tagging
locals {
  default_tags = {
    environment = "${terraform.workspace}"
  }

  tags = "${merge(local.default_tags,var.tags)}"
}

variable "tags" {
  type    = "map"
  default = {}
}
