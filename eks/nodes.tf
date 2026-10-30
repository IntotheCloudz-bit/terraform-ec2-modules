
# =========================================
# EC2 LAUNCH TEMPLATE FOR EKS NODES
# =========================================

resource "aws_launch_template" "nodes" {
  name_prefix = "${var.name}-nodes-"

  # Encrypted worker-node root storage
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 30
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  # Require IMDSv2 and limit pod access
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  # Monitoring for worker EC2 instances
  monitoring {
    enabled = true
  }

  tags = var.tags
}


# =========================================
# EKS MANAGED NODE GROUP
# =========================================

resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.name}-nodes"

  node_role_arn = aws_iam_role.nodes.arn

  # Keep worker nodes in private subnets
  subnet_ids = var.private_subnet_ids

  # AWS-managed Amazon Linux 2023
  ami_type = "AL2023_x86_64_STANDARD"

  # Instance sizes supplied by the caller
  instance_types = var.node_instance_types

  capacity_type = "ON_DEMAND"

  # Reusable node scaling configuration
  scaling_config {
    min_size     = var.node_scaling.min
    desired_size = var.node_scaling.desired
    max_size     = var.node_scaling.max
  }

  # Controlled worker-node updates
  update_config {
    max_unavailable = 1
  }

  # Hardened EC2 configuration
  launch_template {
    id      = aws_launch_template.nodes.id
    version = aws_launch_template.nodes.latest_version
  }

  tags = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.nodes_worker,
    aws_iam_role_policy_attachment.nodes_ecr,
    aws_eks_addon.vpc_cni,
  ]
}
