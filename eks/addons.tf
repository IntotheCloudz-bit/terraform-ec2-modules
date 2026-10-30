
# =========================================
# COMPATIBLE EKS ADD-ON VERSIONS
# =========================================

data "aws_eks_addon_version" "compatible" {
  for_each = toset([
    "vpc-cni",
    "eks-pod-identity-agent",
    "coredns",
    "kube-proxy"
  ])

  addon_name         = each.key
  kubernetes_version = var.kubernetes_version
  most_recent        = false
}


# =========================================
# EKS POD IDENTITY AGENT
# =========================================

resource "aws_eks_addon" "pod_identity_agent" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "eks-pod-identity-agent"

  addon_version = data.aws_eks_addon_version.compatible[
    "eks-pod-identity-agent"
  ].version

  resolve_conflicts_on_update = "PRESERVE"
  preserve                    = false

  tags = var.tags
}


# =========================================
# VPC CNI NETWORKING
# =========================================

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "vpc-cni"

  addon_version = data.aws_eks_addon_version.compatible[
    "vpc-cni"
  ].version

  # Dedicated IAM role for the CNI service account
  pod_identity_association {
    service_account = "aws-node"
    role_arn        = aws_iam_role.cni.arn
  }

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  preserve = false
  tags     = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.cni_policy,
    aws_eks_addon.pod_identity_agent
  ]
}


# =========================================
# KUBE-PROXY
# =========================================

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "kube-proxy"

  addon_version = data.aws_eks_addon_version.compatible[
    "kube-proxy"
  ].version

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  preserve = false
  tags     = var.tags

  depends_on = [
    aws_eks_node_group.nodes
  ]
}


# =========================================
# COREDNS
# =========================================

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "coredns"

  addon_version = data.aws_eks_addon_version.compatible[
    "coredns"
  ].version

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "PRESERVE"

  preserve = false
  tags     = var.tags

  depends_on = [
    aws_eks_node_group.nodes
  ]
}
