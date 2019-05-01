resource "helm_release" "superset" {
  name      = "${var.name}"
  namespace = "${var.namespace}"
  chart     = "stable/superset"
  version   = "${var.version}"

  set {
    name  = "persistence.enabled"
    value = "true"
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "replicas"
    value = "2"
  }
}
