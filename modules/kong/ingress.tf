resource "kubernetes_ingress_v1" "kong_ingress" {
  depends_on = [
    helm_release.kong
  ]
  metadata {
    name      = "${var.name}-ingress"
    namespace = var.namespace

    annotations = {
      "konghq.com/strip-path" = "true"
    }

    labels = {
      app = var.name
    }
  }

  spec {
    ingress_class_name = "kong"

    rule {
      host = var.host

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = var.name
              port {
                number = var.service_port
              }
            }
          }
        }
      }
    }
  }
}
