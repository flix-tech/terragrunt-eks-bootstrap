variable "eks_cluster_endpoint" {
  type = string
  default = "dummy"
  description = "describe your variable"
}

variable "eks_cluster_id" {
  type = string
  default = "dummy"
  description = "describe your variable"
}

provider "aws" {
  version = ">= 2.28.1"
  region  = "eu-west-2"
}

provider "kubernetes" { 
  load_config_file       = "false"
  host                   = var.eks_cluster_endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.eks_cluster_id
}

provider "helm" {
  kubernetes { 
    load_config_file       = "false"
    host                   = var.eks_cluster_endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}