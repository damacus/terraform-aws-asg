data "aws_ami" "ecs-optimized" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.*-x86_64-ebs"]
  }
}

resource "aws_launch_configuration" "launch_config" {
  image_id                    = "${data.aws_ami.ecs-optimized.id}"
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  user_data                   = "${var.user_data_script}"
  security_groups             = ["${concat(split(",", aws_security_group.security_group.id),var.security_groups)}"]
  iam_instance_profile        = "${var.instance_profile}"
  key_name                    = "${var.key_name}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  # Recreate the ASG by creating the name using random_pet
  # Random pet changes value based on the launch configuration
  name_prefix = "${
    join("-",
    list(var.name),
    concat(random_pet.asg_name.*.id, list(""))
    )
  }"

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

  tags = ["${
    concat(
      "${data.null_data_source.asg-tags.*.outputs}",
      list(
        map(
          "key", "Name",
          "value", "${terraform.env}_${var.name}",
          "propagate_at_launch", true
        )
      )
    )
  }"]

  depends_on = ["aws_launch_configuration.launch_config"]

  lifecycle {
    create_before_destroy = true
  }
}

data "null_data_source" "asg-tags" {
  count = "${length(keys(local.tags))}"

  inputs = {
    key                 = "${element(keys(local.tags), count.index)}"
    value               = "${element(values(local.tags), count.index)}"
    propagate_at_launch = "true"
  }
}

# Use random_pet to recreate the ASG
resource "random_pet" "asg_name" {
  separator = "-"
  length    = 2

  keepers = {
    # Generate a new pet name each time we switch launch configuration
    lc_name = "${aws_launch_configuration.launch_config.name}"
  }
}
