## Internal Security Group
resource "aws_security_group" "ms_sql" {
  name        = "${var.customer}-${var.envname}-ms-sql-${var.windows_cluster_id}"
  vpc_id      = "${var.vpc_id}"
  description = "ms sql security group"

  tags {
    customer = "${var.customer}"
    envname  = "${var.envname}"
    envtype  = "${var.envtype}"
  }
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
  name        = "${var.customer}-${var.envname}-ms-cluster-${var.windows_cluster_id}"
  vpc_id      = "${var.vpc_id}"
  description = "ms cluster security group"

  tags {
    customer = "${var.customer}"
    envname  = "${var.envname}"
    envtype  = "${var.envtype}"
  }
}

resource "aws_security_group_rule" "cluster_egress_all" {
  type              = "egress"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "65535"
  security_group_id = "${aws_security_group.ms_cluster.id}"
  self              = "true"
}

resource "aws_security_group_rule" "cluster_ingress_all" {
  type              = "ingress"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "65535"
  security_group_id = "${aws_security_group.ms_cluster.id}"
  self              = "true"
}

resource "aws_security_group_rule" "cluster_ads_all" {
  type                     = "egress"
  protocol                 = "-1"
  from_port                = "0"
  to_port                  = "65535"
  security_group_id        = "${aws_security_group.ms_cluster.id}"
  source_security_group_id = "${var.ads_sg_id}"
}

resource "aws_security_group_rule" "ads_cluster_all" {
  type                     = "ingress"
  protocol                 = "-1"
  from_port                = "0"
  to_port                  = "65535"
  security_group_id        = "${var.ads_sg_id}"
  source_security_group_id = "${aws_security_group.ms_cluster.id}"
}

resource "aws_security_group_rule" "cluster_ads_servers" {
  type              = "egress"
  protocol          = "-1"
  from_port         = "0"
  to_port           = "65535"
  security_group_id = "${aws_security_group.ms_cluster.id}"
  cidr_blocks       = ["${element(var.ads_dns,0)}/32", "${element(var.ads_dns,1)}/32"]
}
