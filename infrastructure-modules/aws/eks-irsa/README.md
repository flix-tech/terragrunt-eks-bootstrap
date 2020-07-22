# IAM Roles for Service Accounts

This example shows how to create an IAM role to be used for a Kubernetes `ServiceAccount`. It will create a policy and role to be used by the [cluster-autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler) using the [public Helm chart](https://github.com/helm/charts/tree/master/stable/cluster-autoscaler).

The AWS documentation for IRSA is here: https://docs.aws.amazon.com/eks/latest/userguide/iam-roles-for-service-accounts.html