resource "aws_security_group" "security_group" {
  name        = "${terraform.env}-${var.application}-${var.name}"
  description = "${terraform.env}-${var.application}-${var.name}"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${terraform.env}-${var.application}-${var.name}"
    Environment = "${terraform.env}"
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
