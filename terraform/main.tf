module "vpc" {
  source = "git::ssh://git@github.com/markthub/app-modules.git//vpc?ref=master"
  azs    = "${var.aws_azs}"

  tags = {
    KubernetesCluster                 = "${terraform.workspace}-eks-cluster"
    "kubernetes.io/role/internal-elb" = ""
    Terraform                         = "true"
    Environment                       = "${terraform.workspace}-vpc"
  }
}

module "ssh_key" {
  source   = "git::ssh://git@github.com/markthub/app-modules.git//key?ref=master"
  key_name = "${terraform.workspace}-key-cluster"
}

module "eks" {
  source    = "git::ssh://git@github.com/markthub/app-modules.git//eks?ref=master"
  name      = "eks-admin"
  namespace = "kube-system"

  vpc_id        = "${module.vpc.vpc_id}"
  cluster_name  = "${terraform.workspace}-eks-cluster"
  pub_subnets   = "${module.vpc.public_subnets}"
  prv_subnets   = "${module.vpc.private_subnets}"
  key_name      = "${module.ssh_key.key_name}"
  instance_type = "${var.instance_type}"

  tags = {
    KubernetesCluster                 = "${terraform.workspace}-eks-cluster"
    "kubernetes.io/role/internal-elb" = ""
    Terraform                         = "true"
    Environment                       = "${terraform.workspace}-vpc"
  }
}

module "helm-tiller" {
  source    = "git::ssh://git@github.com/markthub/app-modules.git//helm-tiller?ref=master"
  name      = "tiller"
  namespace = "kube-system"
}

module "dashboard" {
  source    = "git::ssh://git@github.com/markthub/app-modules.git//dashboard?ref=master"
  name      = "kubernetes-dashboard"
  namespace = "kube-system"
}

module "cluster-autoscaler" {
  source    = "git::ssh://git@github.com/markthub/app-modules.git//autoscaler?ref=master"
  name      = "cluster-autoscaler"
  namespace = "kube-system"

  cluster_name = "${module.eks.cluster_name}"
  aws_region   = "${var.aws_region}"
}

module "prometheus" {
  source    = "git::ssh://git@github.com/markthub/app-modules.git//prometheus?ref=master"
  name      = "prometheus"
  namespace = "kube-system"
}

module "grafana" {
  source    = "git::ssh://git@github.com/markthub/app-modules.git//grafana?ref=master"
  name      = "grafana"
  namespace = "kube-system"
}
