generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = file(find_in_parent_folders("providers.tf"))
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "fxt-data-flux-terragrunt-test-dev-state"
    key            = "${basename(get_parent_terragrunt_dir())}/${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "fxt-data-flux-terragrunt-test-dev-state_lock"
    encrypt        = true
  }
}

inputs = {
  ### PROVIDER PARAMETERS
  # set eks parameters after provision eks
  eks_cluster_endpoint = "https://xxxxxxxxx.sk1.eu-west-2.eks.amazonaws.com"
  eks_cluster_id = "test-eks-irsa"
}

iam_role = "arn:aws:iam::xxxxxxxxx:role/xxxxxxxxx"