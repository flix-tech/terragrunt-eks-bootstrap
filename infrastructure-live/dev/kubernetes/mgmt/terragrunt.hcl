include {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infrastructure-modules/kubernetes/mgmt"
}
