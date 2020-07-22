data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "template_file" "helmvalue" {
  template = "${file("cluster-autoscaler-chart-values.yaml.tpl")}"
  vars = {
    aws_account_id = "${data.aws_caller_identity.current.account_id}"
    region = "${data.aws_region.current.name}"
    cluster_name = var.eks_cluster_id
  }
}


resource "helm_release" "cluster-autoscaler" {
  name  = "cluster-autoscaler"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart = "cluster-autoscaler"
  namespace = "kube-system"

  values = [
    data.template_file.helmvalue.rendered,
  ]
}

#helm install spot-handler stable/k8s-spot-termination-handler --namespace kube-system
resource "helm_release" "spot-handler" {
  name  = "spot-handler"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  chart = "k8s-spot-termination-handler"
  namespace = "kube-system"
}