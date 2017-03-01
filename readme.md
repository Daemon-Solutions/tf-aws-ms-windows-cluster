# tf-aws-ms-windows-cluster
Creates Windows Cluster

### Usage

https://git.bashton.net/Bashton-Terraform-Modules/tf-aws-ms-windows-cluster

module "windows_cluster" {

  source                  = "https://git.bashton.net/Bashton-Terraform-Modules/tf-aws-ms-windows-cluster.git"

  customer                = "example_corp"
  envname                 = "example"
  envtype                 = "nonprod"
  azs                     = "${var.azs}"
  key_name                = "${var.key_name}"
  vpc_id                  = "${data.terraform_remote_state.vpc.vpc_id}"
  private_subnets         = "${data.terraform_remote_state.vpc.private_subnets}"
  
  private_subnets_cidrs   = "${data.terraform_remote_state.vpc.private_subnets_cidrs}"
  vpc_cidr                = "${data.terraform_remote_state.vpc.vpc_cidr}"
  domain_name             = "${data.terraform_remote_state.vpc.domain_name}"
  ad_user                 = "${data.terraform_remote_state.vpc.ad_user}"
  domain_password         = "${data.terraform_remote_state.vpc.domain_password}"
  local_password          = "${data.terraform_remote_state.vpc.local_password}"
  aws_region              = "${data.terraform_remote_state.vpc.aws_region}"
  ads_dns                 = "${data.terraform_remote_state.vpc.ads_dns}"
  rdgw_external_sg_id     = "${data.terraform_remote_state.vpc.rdgw_external_sg_id}"
  ads_sg_id               = "${data.terraform_remote_state.vpc.ads_sg_id}"
  security_group_ids      = ["${data.terraform_remote_state.vpc.rdgw_external_sg_id}", "${data.terraform_remote_state.vpc.mgmt_sg_id}", "${data.terraform_remote_state.vpc.ads_sg_id}"]
  userdata                = "${data.template_file.new_relic.rendered}${data.template_file.mk_agent.rendered}"

  disk_sizes              = ["500", "500", "300", "250", "250", "250", "10", "500"]
  disk_names              = ["SQL Data", "SQL Data2", "TempDB", "SQL Log", "SQL Log2", "Page File", "DTC", "Backup"]
  disk_letter             = ["D", "E", "F", "L", "M", "P", "T", "Z"]

  windows_ami             = "ami-369bbf50"

  windows_cluster_id           = "b"
  windows_cluster_azs          = "1"                                  #0=AZa 1=AZb 2=AZc
  windows_cluster_ips          = ["10.211.102.161", "10.211.102.170"]
  windows_cluster_ip           = "10.211.102.161"
  windows_cluster_quorum_ip    = "10.211.102.60"
  windows_cluster_quorum_share = "quorum$"
}

Variables

customer                     - Customer names
envname                      - The name of the environemt or vpc that the clusters are being deployed into
envtype                      - The type of environemt e.g. nonprod, prod
azs                          - List of AZ's
key_name                     - EC2 Keyname from which to build any instances
vpc_id                       - VPC id
private_subnets              - List of private subnet IDs
private_subnets_cidrs        - List of private subnet cidr blocks
vpc_cidr                     - VPC cidr block
domain_name                  - domain name of environment
ad_user                      - admin or administrator , depending on SIMPLE or MS ADS
domain_password              - domain admin password
local_password               - desired local admin password
aws_region                   - AWS region
ads_dns                      - ADS dns servers (also sames as DC ip addresses)
rdgw_external_sg_id          - remote access security group id
ads_sg_id                    - ADS security group id
security_group_ids           - additional security groups ids requiring access to cluster
userdata                     - rendered users data powershell
disk_sizes                   - list of extra drives
disk_names                   - list of drive labels
disk_letter                  - list of drive letters
windows_ami                  - Lindows AMI
windows_cluster_id           - Unique identifier for cluster
windows_cluster_azs          - AZ to deploy cluster into 0=AZa 1=AZb 2=AZc
windows_cluster_ips          - list of cluster node ips
windows_cluster_ip           - cluster ip 
windows_cluster_quorum_ip    - cluster quorum ip address
windows_cluster_quorum_share - quorum share name