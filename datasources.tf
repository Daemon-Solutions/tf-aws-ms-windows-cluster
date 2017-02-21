#retrieve the latest ami for 2008R2/2012R2/2016

data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${lookup(var.windows_ami_names,var.windows_ver)}"]
  }
}

data "template_file" "sql1_instance_userdata" {
  template = "${file("${path.module}/include/sql_instance_userdata.tmpl")}"

  vars {
    drives          = "${join(",", var.disk_letter)}"
    names           = "${join(",", var.disk_names)}"
    vpc_cidr        = "${var.vpc_cidr}"
    cluster_cidr    = "${var.windows_cluster_cidr}"
    hostname        = "${element(var.hostname, 0)}"
    domain_name     = "${var.domain_name}"
    ad_user         = "${var.ad_user}"
    domain_password = "${var.domain_password}"
    local_password  = "${var.local_password}"
    region          = "${var.aws_region}"
    dns_servers     = "${element(var.ads_dns,0)},${element(var.ads_dns,1)}"
  }
}

data "template_file" "sql2_instance_userdata" {
  template = "${file("${path.module}/include/sql_instance_userdata.tmpl")}"

  vars {
    drives          = "${join(",", var.disk_letter)}"
    names           = "${join(",", var.disk_names)}"
    vpc_cidr        = "${var.vpc_cidr}"
    cluster_cidr    = "${var.windows_cluster_cidr}"
    hostname        = "${element(var.hostname, 1)}"
    domain_name     = "${var.domain_name}"
    ad_user         = "${var.ad_user}"
    domain_password = "${var.domain_password}"
    local_password  = "${var.local_password}"
    region          = "${var.aws_region}"
    dns_servers     = "${element(var.ads_dns,0)},${element(var.ads_dns,1)}"
  }
}
