output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane."
  value       = module.eks.cluster_endpoint
}

output "cluster_id" {
  value       = module.eks.cluster_id
}

