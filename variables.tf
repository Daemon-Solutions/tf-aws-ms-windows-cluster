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

variable "windows_ami" {}

## Security group variabes

variable "ads_sg_id" {}
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

## Windows Cluster Variables

variable "private_subnets_cidrs" {
  type = "list"
}

variable "windows_cluster_azs" {}
variable "windows_cluster_id" {}

variable "windows_cluster_ips" {
  type = "list"
}

variable "windows_cluster_ip" {}

variable "hostname" {
  default = ["clu1", "clu2"]
}

variable "windows_cluster_quorum_ip" {}

variable "windows_cluster_quorum_share" {}

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
