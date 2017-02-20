resource "aws_instance" "sql1" {

    ami                     = "${data.aws_ami.windows.id}"
    subnet_id               = "${element(var.private_subnets, var.sql_cluster_azs)}"
    instance_type           = "m3.large"
    user_data               = "<powershell>${data.template_file.sql1_instance_userdata.rendered}</powershell><persist>true</persist>"
    iam_instance_profile    = "${module.iam_instance_profile_ms_sql_pull.profile_id}"
    vpc_security_group_ids  = ["${aws_security_group.ms_sql.id}","${var.ads_sg}","${var.mgmt_internal_sg_id}"]
    key_name                = "${var.key_name}"
    private_ip              = "${element(var.sql_1_private_ip, 0)}"

    tags {
        Name                = "${var.customer}-${var.envname}_ms-sql-${var.sql_cluster_id}1"
    }
}

resource "aws_ebs_volume" "sql_disks1" {

    count                   = "${length(var.disk_sizes)}"

    availability_zone       = "${aws_instance.sql1.availability_zone}"
    size                    = "${element(var.disk_sizes, count.index)}"
    type                    = "gp2"

    tags {
        Name = "${element(var.disk_names, count.index)}"
    }
}

resource "aws_volume_attachment" "ebs_att1" {

  count                     = "${length(var.disk_sizes)}"

  device_name               = "${element(var.disk_mappings, count.index)}"
  volume_id                 = "${element(aws_ebs_volume.sql_disks1.*.id, count.index)}"
  instance_id               = "${aws_instance.sql1.id}"
}





resource "aws_instance" "sql2" {

    ami                     = "${data.aws_ami.windows.id}"
    subnet_id               = "${element(var.private_subnets, var.sql_cluster_azs)}"
    instance_type           = "m3.large"
    user_data               = "<powershell>${data.template_file.sql2_instance_userdata.rendered}</powershell><persist>true</persist>"
    iam_instance_profile    = "${module.iam_instance_profile_ms_sql_pull.profile_id}"
    vpc_security_group_ids  = ["${aws_security_group.ms_sql.id}","${var.ads_sg}"]
    key_name                = "${var.key_name}"
    private_ip              = "${element(var.sql_2_private_ip, 0)}"

    tags {
        Name                = "${var.customer}-${var.envname}_ms-sql-${var.sql_cluster_id}2"
    }
}

resource "aws_ebs_volume" "sql_disks2" {

    count                   = "${length(var.disk_sizes)}"
    availability_zone       = "${aws_instance.sql2.availability_zone}"
    size                    = "${element(var.disk_sizes, count.index)}"
    type                    = "gp2"

    tags {
        Name                = "${element(var.disk_names, count.index)}"
    }
}

resource "aws_volume_attachment" "ebs_att2" {

  count                     = "${length(var.disk_sizes)}"

  device_name               = "${element(var.disk_mappings, count.index)}"
  volume_id                 = "${element(aws_ebs_volume.sql_disks2.*.id, count.index)}"
  instance_id               = "${aws_instance.sql2.id}"
}
