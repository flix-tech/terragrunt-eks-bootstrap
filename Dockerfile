FROM alpine/terragrunt:0.12.28-eks

RUN apk add --no-cache alpine-sdk util-linux findutils python3 wget unzip docker jq git bash

# Python dependencies
RUN pip3 install awscli

# TERRAFORM tfenv
RUN git clone https://github.com/tfutils/tfenv.git ~/.tfenv \
    && sudo ln -s ~/.tfenv/bin/* /usr/local/bin

# TERRAGRUNT tgenv
RUN git clone https://github.com/cunymatthieu/tgenv.git ~/.tgenv \
    && sudo ln -s ~/.tgenv/bin/* /usr/local/bin 

# TASKFILE
RUN curl -sL https://taskfile.dev/install.sh | sh \
    && mv bin/task /usr/local/bin

ENV HELM_VERSION=3.2.1
# install Helm v3
RUN curl -Lo helm-v${HELM_VERSION}-linux-amd64.tar.gz https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && sudo mv linux-amd64/helm /usr/local/bin/helm \
    && helm version

# link to providers
# https://releases.hashicorp.com/

# TERRAFORM - KAFKA PROVIDER
RUN TERRAFORM_KAFKA_PROVIDER_VERSION=0.2.3 \
    && wget --no-verbose https://github.com/Mongey/terraform-provider-kafka/releases/download/v"$TERRAFORM_KAFKA_PROVIDER_VERSION"/terraform-provider-kafka_"$TERRAFORM_KAFKA_PROVIDER_VERSION"_linux_amd64.tar.gz \
    && tar -xf terraform-provider-kafka_"$TERRAFORM_KAFKA_PROVIDER_VERSION"_linux_amd64.tar.gz \
    && mkdir -p ~/.terraform.d/plugins \
    && mv terraform-provider-kafka_v"$TERRAFORM_KAFKA_PROVIDER_VERSION" ~/.terraform.d/plugins/

# TERRAFORM - AWS PROVIDER
RUN TERRAFORM_AWS_PROVIDER_VERSION=2.47.0 \
    && wget --no-verbose https://releases.hashicorp.com/terraform-provider-aws/"$TERRAFORM_AWS_PROVIDER_VERSION"/terraform-provider-aws_"$TERRAFORM_AWS_PROVIDER_VERSION"_linux_amd64.zip \
    && unzip terraform-provider-aws_"$TERRAFORM_AWS_PROVIDER_VERSION"_linux_amd64.zip \
    && mkdir -p ~/.terraform.d/plugins \
    && mv terraform-provider-aws_v"$TERRAFORM_AWS_PROVIDER_VERSION"_x4 ~/.terraform.d/plugins/

# TERRAFORM - DATADOG PROVIDER
RUN TERRAFORM_DATADOG_PROVIDER_VERSION=2.6.0 \
    && wget --no-verbose https://releases.hashicorp.com/terraform-provider-datadog/"$TERRAFORM_DATADOG_PROVIDER_VERSION"/terraform-provider-datadog_"$TERRAFORM_DATADOG_PROVIDER_VERSION"_linux_amd64.zip \
    && unzip terraform-provider-datadog_"$TERRAFORM_DATADOG_PROVIDER_VERSION"_linux_amd64.zip \
    && mkdir -p ~/.terraform.d/plugins \
    && mv terraform-provider-datadog_v"$TERRAFORM_DATADOG_PROVIDER_VERSION"_x4 ~/.terraform.d/plugins/

# TERRAFORM - HELM PROVIDER
RUN TERRAFORM_HELM_PROVIDER_VERSION=1.0.0 \
    && wget --no-verbose https://releases.hashicorp.com/terraform-provider-helm/"$TERRAFORM_HELM_PROVIDER_VERSION"/terraform-provider-helm_"$TERRAFORM_HELM_PROVIDER_VERSION"_linux_amd64.zip \
    && unzip terraform-provider-helm_"$TERRAFORM_HELM_PROVIDER_VERSION"_linux_amd64.zip \
    && mkdir -p ~/.terraform.d/plugins \
    && mv terraform-provider-helm_v"$TERRAFORM_HELM_PROVIDER_VERSION"_x4 ~/.terraform.d/plugins/

# TERRAFORM - KUBERNETES PROVIDER
RUN TERRAFORM_KUBERNETES_PROVIDER_VERSION=1.10.0 \
    && wget --no-verbose https://releases.hashicorp.com/terraform-provider-kubernetes/"$TERRAFORM_KUBERNETES_PROVIDER_VERSION"/terraform-provider-kubernetes_"$TERRAFORM_KUBERNETES_PROVIDER_VERSION"_linux_amd64.zip \
    && unzip terraform-provider-kubernetes_"$TERRAFORM_KUBERNETES_PROVIDER_VERSION"_linux_amd64.zip \
    && mkdir -p ~/.terraform.d/plugins \
    && mv terraform-provider-kubernetes_v"$TERRAFORM_KUBERNETES_PROVIDER_VERSION"_x4 ~/.terraform.d/plugins/

# EKS Cluster Access
RUN AWS_IAM_AUTHENTICATOR_VERSION=0.5.0 \
    && wget --no-verbose https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v"$AWS_IAM_AUTHENTICATOR_VERSION"/aws-iam-authenticator_"$AWS_IAM_AUTHENTICATOR_VERSION"_linux_amd64 \
    && mv aws-iam-authenticator_"$AWS_IAM_AUTHENTICATOR_VERSION"_linux_amd64 aws-iam-authenticator \
    && chmod +x aws-iam-authenticator \
    && mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

# TERRAFORM - EXTERNAL PROVIDER
RUN TERRAFORM_EXTERNAL_PROVIDER_VERSION=1.2.0 \
    && wget --no-verbose https://releases.hashicorp.com/terraform-provider-external/"$TERRAFORM_EXTERNAL_PROVIDER_VERSION"/terraform-provider-external_"$TERRAFORM_EXTERNAL_PROVIDER_VERSION"_linux_amd64.zip \
    && unzip terraform-provider-external_"$TERRAFORM_EXTERNAL_PROVIDER_VERSION"_linux_amd64.zip \
    && mkdir -p ~/.terraform.d/plugins \
    && mv terraform-provider-external_v"$TERRAFORM_EXTERNAL_PROVIDER_VERSION"_x4 ~/.terraform.d/plugins/

# TERRAFORM - NULL PROVIDER
RUN TERRAFORM_NULL_PROVIDER_VERSION=2.1.2 \
    && wget --no-verbose https://releases.hashicorp.com/terraform-provider-null/"$TERRAFORM_NULL_PROVIDER_VERSION"/terraform-provider-null_"$TERRAFORM_NULL_PROVIDER_VERSION"_linux_amd64.zip \
    && unzip terraform-provider-null_"$TERRAFORM_NULL_PROVIDER_VERSION"_linux_amd64.zip \
    && mkdir -p ~/.terraform.d/plugins \
    && mv terraform-provider-null_v"$TERRAFORM_NULL_PROVIDER_VERSION"_x4 ~/.terraform.d/plugins/
