#retrieve the latest ami for 2008R2/2012R2/2016

data "template_file" "sql1_instance_userdata" {
  template = "${file("${path.module}/include/cluster_instance_userdata.tmpl")}"

  vars {
    drives                       = "${join(",", var.disk_letter)}"
    names                        = "${join(",", var.disk_names)}"
    vpc_cidr                     = "${var.vpc_cidr}"
    hostname                     = "clu-${var.windows_cluster_id}-1"
    domain_name                  = "${var.domain_name}"
    ad_user                      = "${var.ad_user}"
    domain_password              = "${var.domain_password}"
    local_password               = "${var.local_password}"
    region                       = "${var.aws_region}"
    dns_servers                  = "${element(var.ads_dns,0)},${element(var.ads_dns,1)}"
    windows_cluster_ip           = "${var.windows_cluster_ip}"
    windows_cluster_quorum_ip    = "${var.windows_cluster_quorum_ip}"
    windows_cluster_quorum_share = "${var.windows_cluster_quorum_share}"
    windows_cluster_id           = "${var.windows_cluster_id}"
  }
}

data "template_file" "sql2_instance_userdata" {
  template = "${file("${path.module}/include/cluster_instance_userdata.tmpl")}"

  vars {
    drives                       = "${join(",", var.disk_letter)}"
    names                        = "${join(",", var.disk_names)}"
    vpc_cidr                     = "${var.vpc_cidr}"
    hostname                     = "clu-${var.windows_cluster_id}-2"
    domain_name                  = "${var.domain_name}"
    ad_user                      = "${var.ad_user}"
    domain_password              = "${var.domain_password}"
    local_password               = "${var.local_password}"
    region                       = "${var.aws_region}"
    dns_servers                  = "${element(var.ads_dns,0)},${element(var.ads_dns,1)}"
    windows_cluster_ip           = "${var.windows_cluster_ip}"
    windows_cluster_quorum_ip    = "${var.windows_cluster_quorum_ip}"
    windows_cluster_quorum_share = "${var.windows_cluster_quorum_share}"
    windows_cluster_id           = "${var.windows_cluster_id}"
  }
}
