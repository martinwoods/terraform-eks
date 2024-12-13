#########################################################
# EKS On-demand-ml Node Group details
#########################################################

resource "aws_eks_node_group" "on_demand_ml_node_group" {
  cluster_name         = "${var.cluster_name}"
  node_group_name      = "${var.cluster_name}-worker-on-demand-ml-node-group"
  node_role_arn        = "${var.aws_iam_role_eks_node_group_role_arn}"
  subnet_ids           = split(",", var.eks_private_subnet_ids)
  capacity_type        = "ON_DEMAND"
  force_update_version = true

  scaling_config {
    desired_size = var.asg_desired_size_ml
    max_size     = var.asg_max_size_ml
    min_size     = var.asg_min_size_ml
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = split(",", var.ec2_instance_types_worker_node_ml)

  launch_template {
    id      = aws_launch_template.as_lt_node_group_ml.id
    version = aws_launch_template.as_lt_node_group_ml.latest_version
  }

  # Taints & Tolerations to prevent other pods from being scheduled on the ML dedicated nodes.
  # Then we use Node Affinity to have ML pods scheduled on the ML dedicated nodes.
  taint {
    key    = "isMLApp"
    value  = "true"
    effect = "NO_SCHEDULE"
  }

  labels = {
    isMLNode = "true"
  }

  tags = tomap({
    "Name"                                      = "${var.cluster_name}-worker-on-demand-ml-nodes"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  })

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  # depends_on = [aws_eks_cluster.eks]
}


#########################################################
# EC2 Launch Template details
#########################################################

resource "aws_launch_template" "as_lt_node_group_ml" {
  name_prefix            = "${var.cluster_name}-"
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
    security_groups = ["${var.sg_worker_nodes}"]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      AppID   = "Vector Cloud"
      AppRole = "OnDemand-ml Node"
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
# Schedule turning on/off in the evening time 6pm – 8pm
############################################################

resource "aws_autoscaling_schedule" "on_demand_ml_nodes_stop_evening" {
  scheduled_action_name  = "${var.cluster_name}-asg-on-demand-ml-stop-evening"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  autoscaling_group_name = aws_eks_node_group.on_demand_ml_node_group.resources[0].autoscaling_groups[0].name
  recurrence             = var.asg_cron_ml_nodes_stop_evening
  time_zone              = "Europe/Dublin"

  depends_on = [aws_eks_node_group.on_demand_ml_node_group]
}

resource "aws_autoscaling_schedule" "on_demand_ml_nodes_start_evening" {
  scheduled_action_name  = "${var.cluster_name}-asg-on-demand-ml-start-evening"
  min_size               = var.asg_min_size_ml
  max_size               = var.asg_max_size_ml
  desired_capacity       = var.asg_desired_size_ml
  autoscaling_group_name = aws_eks_node_group.on_demand_ml_node_group.resources[0].autoscaling_groups[0].name
  recurrence             = var.asg_cron_ml_nodes_start_evening
  time_zone              = "Europe/Dublin"

  depends_on = [aws_eks_node_group.on_demand_ml_node_group]
}

############################################################
# Schedule turning on/off in the night time 3am – 5am
############################################################

resource "aws_autoscaling_schedule" "on_demand_ml_nodes_stop_night" {
  scheduled_action_name  = "${var.cluster_name}-asg-on-demand-ml-stop-night"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  autoscaling_group_name = aws_eks_node_group.on_demand_ml_node_group.resources[0].autoscaling_groups[0].name
  recurrence             = var.asg_cron_ml_nodes_stop_night
  time_zone              = "Europe/Dublin"

  depends_on = [aws_eks_node_group.on_demand_ml_node_group]
}

resource "aws_autoscaling_schedule" "on_demand_ml_nodes_start_night" {
  scheduled_action_name  = "${var.cluster_name}-asg-on-demand-ml-start-night"
  min_size               = var.asg_min_size_ml
  max_size               = var.asg_max_size_ml
  desired_capacity       = var.asg_desired_size_ml
  autoscaling_group_name = aws_eks_node_group.on_demand_ml_node_group.resources[0].autoscaling_groups[0].name
  recurrence             = var.asg_cron_ml_nodes_start_night
  time_zone              = "Europe/Dublin"

  depends_on = [aws_eks_node_group.on_demand_ml_node_group]
}