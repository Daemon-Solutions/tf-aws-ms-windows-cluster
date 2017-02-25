resource "aws_placement_group" "cluster" {
  name     = "${var.windows_cluster_id}-pgr"
  strategy = "cluster"
}
