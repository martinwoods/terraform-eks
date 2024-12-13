resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy" {
  role       = aws_iam_role.eks_ebs_csi_driver_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"

  depends_on = [aws_iam_role.eks_ebs_csi_driver_role]
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_ebs_encryption_policy" {
  role       = aws_iam_role.eks_ebs_csi_driver_role.name
  policy_arn = aws_iam_policy.csi_driver_encrypt_permissions.arn

  depends_on = [aws_iam_role.eks_ebs_csi_driver_role, aws_iam_policy.csi_driver_encrypt_permissions]
}