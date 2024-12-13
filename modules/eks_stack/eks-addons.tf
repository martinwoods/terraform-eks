resource "aws_eks_addon" "addons" {
  for_each                    = { for addon in var.addons : addon.name => addon }
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = each.value.name
  addon_version               = data.aws_eks_addon_version.addon_versions[each.key].id == each.value.name ? data.aws_eks_addon_version.addon_versions[each.key].version : ""
  service_account_role_arn    = each.value.name == "aws-ebs-csi-driver" ? aws_iam_role.eks_ebs_csi_driver_role.arn : ""
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  tags = {
    Name = local.cluster_name
  }
}