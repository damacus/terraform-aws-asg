resource "aws_security_group" "security_group" {
  name        = "${var.environment}-${var.application}-${var.name}"
  description = "${var.environment}-${var.application}-${var.name}"
  vpc_id      = "${var.vpc_id}"

  asg_termination_policies = "${var.asg_termination_policies}"

  tags {
    Name        = "${var.environment}-${var.application}-${var.name}"
    Environment = "${var.environment}"
    Application = "${var.application}"
  }
}

resource "aws_security_group_rule" "self_ingress" {
  type              = "ingress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  self              = true
  security_group_id = "${aws_security_group.security_group.id}"
}

resource "aws_security_group_rule" "self_egress" {
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  self              = true
  security_group_id = "${aws_security_group.security_group.id}"
}
