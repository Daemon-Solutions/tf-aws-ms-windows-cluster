resource "aws_instance" "sql1" {
  ami                    = "${data.aws_ami.windows.id}"
  subnet_id              = "${element(var.private_subnets, var.windows_cluster_azs)}"
  instance_type          = "m4.large"
  user_data              = "<powershell>${data.template_file.sql1_instance_userdata.rendered}${var.userdata}</powershell><persist>true</persist>"
  iam_instance_profile   = "${module.iam_instance_profile_ms_sql_pull.profile_id}"
  vpc_security_group_ids = ["${var.security_group_ids}", "${aws_security_group.ms_cluster.id}"]
  key_name               = "${var.key_name}"
  private_ip             = "${element(var.windows_cluster_ips, 0)}"
  placement_group        = "${aws_placement_group.cluster.id}"

  tags {
    Name = "${var.customer}-${var.envname}_ms-sql-${var.windows_cluster_id}1"
  }
}

resource "aws_ebs_volume" "sql_disks1" {
  count = "${length(var.disk_sizes)}"

  availability_zone = "${aws_instance.sql1.availability_zone}"
  size              = "${element(var.disk_sizes, count.index)}"
  type              = "gp2"

  tags {
    Name = "${var.customer}-${var.windows_cluster_id}1-${element(var.disk_names, count.index)}"
  }
}

resource "aws_volume_attachment" "ebs_att1" {
  count = "${length(var.disk_sizes)}"

  device_name = "${element(var.disk_mappings, count.index)}"
  volume_id   = "${element(aws_ebs_volume.sql_disks1.*.id, count.index)}"
  instance_id = "${aws_instance.sql1.id}"
}

resource "aws_instance" "sql2" {
  ami                    = "${data.aws_ami.windows.id}"
  subnet_id              = "${element(var.private_subnets, var.windows_cluster_azs)}"
  instance_type          = "m4.large"
  user_data              = "<powershell>${data.template_file.sql2_instance_userdata.rendered}${var.userdata}</powershell><persist>true</persist>"
  iam_instance_profile   = "${module.iam_instance_profile_ms_sql_pull.profile_id}"
  vpc_security_group_ids = ["${var.security_group_ids}", "${aws_security_group.ms_cluster.id}"]
  key_name               = "${var.key_name}"
  private_ip             = "${element(var.windows_cluster_ips, 1)}"
  placement_group        = "${aws_placement_group.cluster.id}"

  tags {
    Name     = "${var.customer}-${var.envname}_ms-sql-${var.windows_cluster_id}2"
    customer = "${var.customer}"
    envname  = "${var.envname}"
    envtype  = "${var.envtype}"
  }
}

resource "aws_ebs_volume" "sql_disks2" {
  count             = "${length(var.disk_sizes)}"
  availability_zone = "${aws_instance.sql2.availability_zone}"
  size              = "${element(var.disk_sizes, count.index)}"
  type              = "gp2"

  tags {
    Name     = "${var.customer}-${var.windows_cluster_id}2-${element(var.disk_names, count.index)}"
    customer = "${var.customer}"
    envname  = "${var.envname}"
    envtype  = "${var.envtype}"
  }
}

resource "aws_volume_attachment" "ebs_att2" {
  count = "${length(var.disk_sizes)}"

  device_name = "${element(var.disk_mappings, count.index)}"
  volume_id   = "${element(aws_ebs_volume.sql_disks2.*.id, count.index)}"
  instance_id = "${aws_instance.sql2.id}"
}
