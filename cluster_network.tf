resource "aws_network_interface" "sql1_eni1" {

    count                   = "1"

    subnet_id               = "${aws_subnet.windows_cluster.id}"
    private_ips             = ["${element(var.sql_1_private_ip, count.index + 1)}"]
    security_groups         = ["${aws_security_group.ms_cluster.id}"]

    attachment {
        instance            = "${aws_instance.sql1.id}"
        device_index        = "${count.index + 1}"
    }
}

resource "aws_network_interface" "sql1_eni2" {

    count                   = "1"

    subnet_id               = "${aws_subnet.windows_cluster.id}"
    private_ips             = ["${element(var.sql_2_private_ip, count.index + 1)}"]
    security_groups         = ["${aws_security_group.ms_cluster.id}"]

    attachment {
        instance            = "${aws_instance.sql2.id}"
        device_index        = "${count.index + 1}"
    }
}


resource "aws_subnet" "windows_cluster" {
    vpc_id = "${var.vpc_id}"
    cidr_block = "${var.windows_cluster_cidr}"
    availability_zone         = "${element(var.azs, var.sql_cluster_azs)}"
    map_public_ip_on_launch   = "false"

    tags {
      Name                    = "${var.customer}-${var.envname}-cl-${element(var.azs, var.sql_cluster_azs)}"
      Environment             = "${var.envname}"
      EnvType                 = "${var.envtype}"
      }
}
