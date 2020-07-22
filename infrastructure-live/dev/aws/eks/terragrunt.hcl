inputs = {
  cluster_name = "test-eks-irsa"
  ondemand_asg_max_size = 5
  spot_asg_max_size = 10
  ondemand_instance_types = ["t3.small"]
  spot_instance_types = ["t3.small", "t3.medium", "t3.large"]
}

include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/aws/eks-irsa"
}
