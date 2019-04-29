output "asg_security_group_id" {
  value = "${aws_security_group.security_group.id}"
}

output "asg_id" {
  value = "${aws_autoscaling_group.autoscaling_group.id}"
}

output "asg_name" {
  value = "${aws_autoscaling_group.autoscaling_group.name}"
}

output "asg_arn" {
  value = "${aws_autoscaling_group.autoscaling_group.arn}"
}

output "asg_launch_configuration" {
  value = "${aws_autoscaling_group.autoscaling_group.launch_configuration}"
}

output "aws_autoscaling_group_vpc_zone_identifier" {
  value = "${aws_autoscaling_group.autoscaling_group.vpc_zone_identifier}"
}
