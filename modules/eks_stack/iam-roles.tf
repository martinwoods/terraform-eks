#########################################################
# IAM & Service Role details
#########################################################


#########################################################
# EKS Service Role

/*
    Amazon EKS Prerequisites
    Before you can create an Amazon EKS cluster, you must
    create an IAM role that Kubernetes can assume to create 
    AWS resources. For example, when a load balancer is 
    created, Kubernetes assumes the role to create an Elastic 
    Load Balancing load balancer in your account. 
    This only needs to be done one time and can be used for multiple EKS clusters. 

    see the following:
    https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html#eks-prereqs
*/

resource "aws_iam_role" "eks_service_role" {
  name               = "${local.cluster_name}-service-role"
  description        = "Allows EKS to manage clusters on your behalf."
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF


  tags = {
    Name = "${local.cluster_name}-service-role"
  }
}

# EKS Cluster Policy Attachment
resource "aws_iam_role_policy_attachment" "eks_service_role_cluster_policy" {
  role       = aws_iam_role.eks_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# EKS Service Policy Attachment
resource "aws_iam_role_policy_attachment" "eks_service_role_service_policy" {
  role       = aws_iam_role.eks_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}


#############################
# IAM Role for EKS Node Group
resource "aws_iam_role" "eks_node_group_role" {
  name = "${local.cluster_name}-eks-node-group"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

# EKS Worker Node Group Role Policy Attachment
resource "aws_iam_role_policy_attachment" "eks_node_group_role_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_group_role.name
}

# EKS CNI Role Policy Attachment
resource "aws_iam_role_policy_attachment" "eks_node_group_role_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_group_role.name
}

# EKS Container Registry Policy Attachment
resource "aws_iam_role_policy_attachment" "eks_node_group_role_container_registry_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_group_role.name
}

# ${local.cluster_name}-secrets-manager Policy Attachment
resource "aws_iam_role_policy_attachment" "secrets_manager_policy" {
  policy_arn = aws_iam_policy.iam_policy_secrets_manager.arn
  role       = aws_iam_role.eks_node_group_role.name
}

# DLM Role Details
resource "aws_iam_role" "dlm_lifecycle_role" {
  name        = "${local.cluster_name}-dlm-lifecycle-role"
  description = "Allows DLM to manage snapshot backup automatically."

  tags = {
    Name = "${local.cluster_name}-dlm_lifecycle_iam"
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "dlm.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Amazon EBS CSI driver IAM role for service accounts
resource "aws_iam_role" "eks_ebs_csi_driver_role" {
  name        = "${local.cluster_name}_EBS_CSI_DriverRole"
  description = "EBS CSI driver allows EKS clusters to manage the lifecycle of Amazon EBS volumes for PV."

  tags = {
    Name = "${local.cluster_name}-EBS-CSI-Driver-Role"
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.tls_certificate.eks_tls_certificate.url, "https://", "")}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${replace(data.tls_certificate.eks_tls_certificate.url, "https://", "")}:aud": "sts.amazonaws.com",
          "${replace(data.tls_certificate.eks_tls_certificate.url, "https://", "")}:sub": "system:serviceaccount:kube-system:ebs-csi-controller-sa"
        }
      }
    }
  ]
}
EOF

  depends_on = [aws_iam_openid_connect_provider.eks_iam_openid_identity_provider]
}
