Declare a module in your Terraform file, for example:

module "ms-sql" {
    source = "https://git.bashton.net/Bashton-Terraform-Modules/ts-aws-ms-sql-cluster.git"


    customer                = string of customer name
	envname                 = string of environment name
	envtype                 = string of type

    azs	                    = list of AZs (default set)
	key_name                = string of key name for instance resource
	userdata                = string of domain join userdata

	vpc_id                  = string of vpc id
	ads_sg                  = string active directory security group
	rdgw_internal_sg_id     = string of remote gateway security group
	private_subnets         = list of private subnet ids
	private_subnets_cidrs   = list of private subnet cidr blocks


	disk_sizes              = ["10","20","30","40"]
   	disk_names              = ["SystemDB","tempDB","userDB","userLOGS"]
   	disk_letter             = ["v","u","t","s"]
    }


EXAMPLE to go in bashton-windows\aws\terraform\infra\20-sql.tf


module "ms-sql" {
  source = "../localmodules/tf-aws-ms-sql"

customer                = "${var.customer}"
envname                 = "${var.envname}"
envtype                 = "${var.envtype}"
azs                     = "${var.azs}"

key_name                = "${var.key_name}"
userdata                = "${data.terraform_remote_state.vpc.domain_connect_userdata_rendered}"
vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
private_subnets         = "${data.terraform_remote_state.vpc.private_subnets}"
ads_sg                  = "${data.terraform_remote_state.vpc.ads_sg_id}"
rdgw_external_sg_id     = "${data.terraform_remote_state.vpc.rdgw_external_sg_id}"
private_subnets_cidrs   = "${data.terraform_remote_state.vpc.private_subnets_cidrs}"

disk_sizes              = ["10","20","30","40"]
disk_names              = ["SystemDB","tempDB","userDB","userLOGS"]
disk_letter             = ["v","u","t","s"]


}
