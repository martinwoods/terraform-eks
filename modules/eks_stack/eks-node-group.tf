#########################################################
# EKS On-demand Node Group details
#########################################################

resource "aws_eks_node_group" "on_demand_node_group" {
  cluster_name         = aws_eks_cluster.eks.name
  node_group_name      = "${local.cluster_name}-worker-on-demand-node-group"
  node_role_arn        = aws_iam_role.eks_node_group_role.arn
  subnet_ids           = [aws_subnet.subnet_private_01.id, aws_subnet.subnet_private_02.id, aws_subnet.subnet_private_03.id]
  capacity_type        = "ON_DEMAND"
  force_update_version = true

  scaling_config {
    desired_size = var.asg_desired_size
    max_size     = var.asg_max_size
    min_size     = var.asg_min_size
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = split(",", var.ec2_instance_type_worker_node)

  launch_template {
    id      = aws_launch_template.as_lt_node_group.id
    version = aws_launch_template.as_lt_node_group.latest_version
  }

  tags = tomap({
    "Name"                                        = "${local.cluster_name}-worker-on-demand-nodes"
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  })

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [aws_eks_cluster.eks]
}


#########################################################
# EC2 Launch Template details
#########################################################

resource "aws_launch_template" "as_lt_node_group" {
  name_prefix            = "${local.cluster_name}-"
  image_id               = data.aws_ami.eks_node.id
  key_name               = var.ec2_key_name
  update_default_version = false
  user_data              = base64encode(local.eks-node-userdata)
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 60
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }
  lifecycle {
    ignore_changes = [
      metadata_options
    ]
  }
  metadata_options {
    http_tokens = "required"
  }
  network_interfaces {
    security_groups = [aws_security_group.sg_worker_nodes_01.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      AppID   = "Vector Cloud"
      AppRole = "OnDemand Node"
      Client  = var.client
      Env     = var.env
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = {
      AppID   = "Vector Cloud"
      AppRole = "Disk"
      Client  = var.client
      Env     = var.env
    }
  }
}

############################################################
# Reducing AWS costs by turning off dev/test envs over night
############################################################

resource "aws_autoscaling_schedule" "on_demand_nodes_stop" {
  count                  = strcontains(var.env, "dev") || strcontains(var.env, "test") || strcontains(var.env, "perf") || strcontains(var.env, "fb") || strcontains(var.env, "auto") ? 1 : 0
  scheduled_action_name  = "${local.cluster_name}-asg-on-demand-stop"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  autoscaling_group_name = aws_eks_node_group.on_demand_node_group.resources[0].autoscaling_groups[0].name
  recurrence             = var.asg_cron_nodes_stop
  time_zone              = "Europe/Dublin"

  depends_on = [aws_eks_node_group.on_demand_node_group]
}

resource "aws_autoscaling_schedule" "on_demand_nodes_start" {
  count                  = strcontains(var.env, "dev") || strcontains(var.env, "test") || strcontains(var.env, "perf") || strcontains(var.env, "fb") || strcontains(var.env, "auto") ? 1 : 0
  scheduled_action_name  = "${local.cluster_name}-asg-on-demand-start"
  min_size               = var.asg_min_size
  max_size               = var.asg_max_size
  desired_capacity       = var.asg_desired_size
  autoscaling_group_name = aws_eks_node_group.on_demand_node_group.resources[0].autoscaling_groups[0].name
  recurrence             = var.asg_cron_nodes_start
  time_zone              = "Europe/Dublin"

  depends_on = [aws_eks_node_group.on_demand_node_group]
}