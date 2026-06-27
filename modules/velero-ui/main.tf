resource "helm_release" "velero_ui" {
  name             = "velero-ui"
  repository       = "https://helm.otwld.com/"
  chart            = "velero-ui"
  namespace        = "velero-ui"
  create_namespace = true

  wait    = true
  timeout = 300
}
