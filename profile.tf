module "iam_instance_profile_ms_sql_pull" {
  source = "../tf-aws-iam-instance-profile"

  name         = "${var.customer}-ms-sql-${var.windows_cluster_id}"
  ec2_describe = "1"
  ec2_attach   = "1"
  s3_readonly  = "1"
  r53_update   = "1"
  ssm_managed  = "1"
}
