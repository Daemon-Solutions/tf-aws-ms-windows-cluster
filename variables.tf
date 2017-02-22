##Customer environment variables

variable "customer" {}
variable "envname" {}
variable "envtype" {}

## VPC Variables

variable "aws_region" {}
variable "vpc_id" {}
variable "vpc_cidr" {}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  default     = []
}

variable "azs" {
  type    = "list"
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

## Userdata Variables

variable "userdata" {
  default = ""
}

## Launch Configuration Variables & ami lookup

variable "windows_ami_names" {
  default = {
    "2008" = "Windows_Server-2008-R2_SP1-English-64Bit-Base-*"
    "2012" = "Windows_Server-2012-R2_RTM-English-64Bit-Base-*"
    "2016" = "Windows_Server-2016-English-Full-Base*"
  }
}

variable "windows_ver" {}

## Security group variabes

#variable "ads_sg" {}
variable "rdgw_external_sg_id" {}

#variable "mgmt_internal_sg_id" {}

variable "security_group_ids" {
  type = "list"
}

## Volume Variables

variable "disk_sizes" {
  type = "list"
}

variable "disk_names" {
  type = "list"
}

variable "disk_letter" {
  type = "list"
}

variable "disk_mappings" {
  default = ["xvdb", "xvdc", "xvdd", "xvde", "xvdf", "xvdg", "xvdh", "xvdi", "xvdj", "xvdk", "xvdl", "xvdm", "xvdn", "xvdo", "xvdp", "xvdq", "xvdr", "xvds", "xvdt", "xvdu", "xvdv", "xvdw", "xvdx", "xvdy", "xvdz"]
}

## SQL Cluster Variables

variable "private_subnets_cidrs" {
  type = "list"
}

variable "sql_cluster_azs" {}
variable "sql_cluster_id" {}

variable "sql_1_private_ip" {
  type = "list"
}

variable "sql_2_private_ip" {
  type = "list"
}

variable "windows_cluster_cidr" {}

variable "hostname" {
  default = ["clu1", "clu2"]
}

## Windows/AD variables

variable "key_name" {}

variable "admin_users" {
  default = {
    "SimpleAD"    = "administrator"
    "MicrosoftAD" = "admin"
  }
}

variable "domain_name" {}
variable "ad_user" {}
variable "domain_password" {}
variable "local_password" {}

variable "ads_dns" {
  type = "list"
}
