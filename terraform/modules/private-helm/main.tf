resource "helm_repository" "ingress-merge" {
  name     = "rtl-helm"
  username = "xxx"
  password = "xxx"
  url      = "https://stash.rtlnederland.nl/projects/CI/repos/rtl-helm/raw/?at=refs%2Fheads%2Fft_ingress-merge"
}

resource "helm_release" "ingress-merge" {
  name       = "ingress-merge"
  chart      = "rtl-helm/ingress-merge"
  version    = "0.1-alpha1"
  repository = "${helm_repository.ingress-merge.metadata.0.name}"
  namespace  = "kube-system"
}
