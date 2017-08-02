resource "aws_launch_configuration" "launch_config" {
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = "${var.map_public_ip}"
  user_data                   = "${var.user_data_script}"
  security_groups             = ["${concat(split(",", aws_security_group.security_group.id),var.security_groups)}"]
  iam_instance_profile        = "${var.instance_profile}"
  key_name                    = "${var.key_name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  availability_zones        = ["${var.zones}"]
  name_prefix               = "${var.name} - "
  max_size                  = "${var.asg_max_size}"
  min_size                  = "${var.asg_min_size}"
  desired_capacity          = "${var.asg_desired_capacity}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.launch_config.name}"
  termination_policies      = "${var.termination_policies}"
  enabled_metrics           = ["${var.enabled_metrics}"]
  vpc_zone_identifier       = ["${var.subnets}"]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "owner"
    value               = "${var.owner}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "${terraform.env}_${var.name}_${count.index}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Description"
    value               = "${var.description}"
    propagate_at_launch = true
  }

  tag {
    key                 = "email"
    value               = "${var.email}"
    propagate_at_launch = true
  }

  tag {
    key                 = "cost_code"
    value               = "${var.cost_code}"
    propagate_at_launch = true
  }

  tag {
    key                 = "environment"
    value               = "${terraform.env}"
    propagate_at_launch = true
  }
}
