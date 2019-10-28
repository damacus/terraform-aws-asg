variable "vpc_id" {
  description = "VPC id to place the security group in"
}

variable "security_groups" {
  description = "A list of additional securiyy groups to attach to the ASG"
  type        = list(string)
  default     = []
}

variable "instance_profile" {
  description = "IAM instance profile to attach to the ASG"
  default     = ""
}

variable "name" {
  description = "Name for the ASG"
}

variable "instance_type" {
  description = "A EC2 instance type for the ASG"
  default     = "t2.medium"
}

# ASG
variable "user_data_script" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument"
}

variable "subnets" {
  description = "A list of subnets for the autoscaling_group vpc_zone_identifier"
  type        = list(string)
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. By default all are collected"
  type        = list(string)

  default = [
    "GroupTerminatingInstances",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupPendingInstances",
    "GroupInServiceInstances",
    "GroupMinSize",
    "GroupTotalInstances",
    "GroupStandbyInstances",
  ]
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated"
  type        = list(string)
  default     = ["OldestLaunchConfiguration", "ClosestToNextInstanceHour"]
}

variable "health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  default     = "EC2"
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = "300"
}

variable "associate_public_ip_address" {
  description = " Associate a public ip address with an instance in a VPC"
  default     = false
}

variable "key_name" {
  description = "The key name that should be used for the instance"
  default     = ""
}

## Launch Configuration
variable "volume_type" {
  default     = "gp2"
  description = "The type of volume. Can be standard, gp2, or io1."
}

variable "volume_size" {
  default     = 30
  description = "The size of the volume in gigabytes."
}

## AutoScalling
variable "asg_min_size" {
  description = "Minimum number of instances during standard operation"
}

variable "asg_max_size" {
  description = "Maximum number of instances during standard operation"
}

variable "asg_desired_capacity" {
  description = "Desired number of instances during standard operation"
}

variable "asg_min_size_up" {
  description = "Minimum number of instances after the scheduled UP action (see aws_autoscaling_schedule.up)"
}

variable "asg_max_size_up" {
  description = "Maximum number of instances after the scheduled UP action (see aws_autoscaling_schedule.up)"
}

variable "asg_desired_capacity_up" {
  description = "Desired number of instances after the scheduled UP action (see aws_autoscaling_schedule.up)"
}

variable "asg_min_size_down" {
  description = "Minimum number of instances after the scheduled DOWN action (see aws_autoscaling_schedule.down)"
}

variable "asg_max_size_down" {
  description = "Maximum number of instances after the scheduled DOWN action (see aws_autoscaling_schedule.down)"
}

variable "asg_desired_capacity_down" {
  description = "Desired number of instances after the scheduled DOWN action (see aws_autoscaling_schedule.down)"
}

variable "schedule_recurrence_up" {
  description = "Schedule time in Unix cron syntax format for the UP action"
  default     = "* 6 * * 1-5"
}

variable "schedule_recurrence_down" {
  description = "Schedule time in Unix cron syntax format for the DOWN action"
  default     = "* 20 * * 1-5"
}

## Tagging
locals {
  default_tags = {
    environment = terraform.workspace
  }

  tags = merge(local.default_tags, var.tags)
}

variable "tags" {
  type    = map(string)
  default = {}
}

