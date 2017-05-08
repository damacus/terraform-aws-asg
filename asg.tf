resource "aws_launch_configuration" "launch_config" {
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = false
  user_data                   = "${template_file.user_data.rendered}"
  # user_data            = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.default.name} > /etc/ecs/ecs.config"

  security_groups      = ["${concat(aws_security_group.security_group.id, var.security_groups)}"]
  iam_instance_profile = "${var.instance_profile}"

  lifecycle {
    create_before_destroy = true
  }

  depends_on = ["template_file.user_data"]
}

resource "aws_autoscaling_group" "asg" {
  availability_zones        = ["${var.zones}"]
  name                      = "${var.name} - ${aws_launch_configuration.launch_config.name}"
  max_size                  = "${var.asg_max_size}"
  min_size                  = "${var.asg_min_size}"
  desired_capacity          = "${var.asg_desired_capacity}"
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  launch_configuration      = "${aws_launch_configuration.launch_config.name}"
  load_balancers            = ["${aws_elb.windows_elb.name}"]

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
    value               = "${var.environment}_${var.name}_${count.index}"
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
    value               = "${var.environment}"
    propagate_at_launch = true
  }
}
