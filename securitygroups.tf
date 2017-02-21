## Internal Security Group
resource "aws_security_group" "ms_sql" {
  name        = "${var.customer}-${var.envname}-ms-sql"
  vpc_id      = "${var.vpc_id}"
  description = "ms sql security group"
}

resource "aws_security_group_rule" "rdp" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = "3389"
  to_port                  = "3389"
  security_group_id        = "${aws_security_group.ms_sql.id}"
  source_security_group_id = "${var.rdgw_external_sg_id}"
}

resource "aws_security_group_rule" "sql_egress" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "1433"
  to_port           = "1433"
  security_group_id = "${aws_security_group.ms_sql.id}"
  cidr_blocks       = ["${var.private_subnets_cidrs}"]
}

resource "aws_security_group_rule" "sql_ingress" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "1433"
  to_port           = "1433"
  security_group_id = "${aws_security_group.ms_sql.id}"
  cidr_blocks       = ["${var.private_subnets_cidrs}"]
}

resource "aws_security_group" "ms_cluster" {
  name        = "${var.customer}-${var.envname}-ms-cluster"
  vpc_id      = "${var.vpc_id}"
  description = "ms cluster security group"
}

resource "aws_security_group_rule" "cluster_ingress_tcp" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "3343"
  to_port           = "3343"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_egress_tcp" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "3343"
  to_port           = "3343"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_ingress_udp" {
  type              = "ingress"
  protocol          = "udp"
  from_port         = "3343"
  to_port           = "3343"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_egress_udp" {
  type              = "egress"
  protocol          = "udp"
  from_port         = "3343"
  to_port           = "3343"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_winrm_ingress_" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "5985"
  to_port           = "5985"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_winrm_egress" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "5985"
  to_port           = "5985"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_winrms_ingress" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "5986"
  to_port           = "5986"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_winrms_egress" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "5986"
  to_port           = "5986"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_dynamic_ingress_tcp" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = "49152"
  to_port           = "65535"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_dynamic_egress_tcp" {
  type              = "egress"
  protocol          = "tcp"
  from_port         = "49152"
  to_port           = "65535"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_dynamic_ingress_udp" {
  type              = "ingress"
  protocol          = "udp"
  from_port         = "49152"
  to_port           = "65535"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_dynamic_egress_udp" {
  type              = "egress"
  protocol          = "udp"
  from_port         = "49152"
  to_port           = "65535"
  self              = "true"
  security_group_id = "${aws_security_group.ms_cluster.id}"
}
