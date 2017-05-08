resource "aws_autoscaling_schedule" "up" {
  scheduled_action_name  = "up"
  min_size               = "${var.asg_min_size_up}"
  max_size               = "${var.asg_max_size_up}"
  desired_capacity       = "${var.asg_desired_capacity_up}"
  recurrence             = "${var.schedule_recurrence_up}"
  autoscaling_group_name = "${aws_autoscaling_group.autoscaling_group.name}"
}

resource "aws_autoscaling_schedule" "down" {
  scheduled_action_name  = "down"
  min_size               = "${var.asg_min_size_down}"
  max_size               = "${var.asg_max_size_down}"
  desired_capacity       = "${var.asg_desired_capacity_down}"
  recurrence             = "${var.schedule_recurrence_up}"
  autoscaling_group_name = "${aws_autoscaling_group.autoscaling_group.name}"
}
