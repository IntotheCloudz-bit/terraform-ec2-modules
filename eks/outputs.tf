
# =========================================
# EKS CLUSTER OUTPUTS
# =========================================

output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.this.name
}

output "cluster_arn" {
  description = "ARN of the EKS cluster"
  value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
  description = "Kubernetes API server endpoint"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64-encoded cluster CA certificate"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_security_group_id" {
  description = "EKS-managed cluster security group ID"
  value       = aws_eks_cluster.this.vpc_config[0].cluster_security_group_id
}


# =========================================
# WORKER NODE OUTPUTS
# =========================================

output "node_group_name" {
  description = "Name of the EKS managed node group"
  value       = aws_eks_node_group.nodes.node_group_name
}

output "node_role_arn" {
  description = "IAM role ARN used by EKS worker nodes"
  value       = aws_iam_role.nodes.arn
}


# =========================================
# POD NETWORKING IAM OUTPUTS
# =========================================

output "cni_role_arn" {
  description = "IAM role ARN used by the VPC CNI"
  value       = aws_iam_role.cni.arn
}
