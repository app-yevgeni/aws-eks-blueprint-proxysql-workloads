
resource "helm_release" "kong" {
  name             = "kong"
  namespace        = "kong"
  create_namespace = true

  repository = "https://charts.konghq.com"
  chart      = "kong"

  set = [
    {
      name  = "ingressController.installCRDs"
      value = "false"
    },
    {
      name  = "ingressController.gatewayAPI.enabled"
      value = "true"
    },
    {
      name  = "proxy.type"
      value = "LoadBalancer"
    },
    {
      name  = "proxy.externalTrafficPolicy"
      value = "Local"
    },
    {
      name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
      value = "nlb"
    },
    {
      name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-scheme"
      value = "internet-facing"
    },
    {
      name  = "proxy.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-nlb-target-type"
      value = "ip"
    }
  ]
}
