#########################################################
# user data for EKS Node Group nodes
#########################################################

locals {

  eks-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh ${var.cluster_name} \
--kubelet-extra-args \
  '--node-labels=lifecycle=on-demand,node.kubernetes.io/worker \
   --kube-reserved cpu=150m,memory=0.4Gi,ephemeral-storage=1Gi \
   --system-reserved cpu=100m,memory=0.4Gi,ephemeral-storage=1Gi \
   --eviction-hard memory.available<800Mi,nodefs.available<10% \
   --register-with-taints=on-demand=true:PreferNoSchedule'
USERDATA

}