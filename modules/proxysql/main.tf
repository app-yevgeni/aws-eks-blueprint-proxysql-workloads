
resource "kubernetes_config_map_v1" "proxysql" {
  metadata {
    name = "proxysql-config"
  }

  data = {
    "proxysql.cnf" = <<EOF
datadir="/var/lib/proxysql"

admin_variables=
{
  mysql_ifaces="0.0.0.0:6032"
}

mysql_variables=
{
  interfaces="0.0.0.0:6033"
  max_connections=2000
}
EOF
  }
}


resource "kubernetes_secret_v1" "proxysql_admin" {
  metadata {
    name = "proxysql-admin"
  }
  type = "Opaque"
  data = {
    admin_user     = base64encode("admin")
    admin_password = base64encode("admin")
  }
}


resource "kubernetes_deployment_v1" "proxysql" {
  metadata {
    name = "proxysql"
    labels = {
      app = "proxysql"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "proxysql"
      }
    }

    template {
      metadata {
        labels = {
          app = "proxysql"
        }
      }

      spec {

        container {

          name  = "proxysql"
          image = "proxysql/proxysql:2.6.3"
          command = [
            "proxysql",
            "-f",
            "-c",
            "/etc/proxysql.cnf"
          ]

          port {
            name           = "admin"
            container_port = 6032
          }
          port {
            name           = "mysql"
            container_port = 6033
          }

          volume_mount {
            name       = "config"
            mount_path = "/etc/proxysql.cnf"
            sub_path   = "proxysql.cnf"

          }

          readiness_probe {
            tcp_socket {
              port = 6032
            }
            initial_delay_seconds = 10
            period_seconds        = 5
          }

          liveness_probe {
            tcp_socket {
              port = 6032
            }
            initial_delay_seconds = 20
            period_seconds        = 10
          }

        }
        volume {
          name = "config"
          config_map {

            name = kubernetes_config_map_v1.proxysql.metadata[0].name

          }
        }

      }
    }
  }
}


resource "kubernetes_service_v1" "proxysql" {
  metadata {
    name = "proxysql"
  }
  spec {
    selector = {
      app = "proxysql"
    }
    port {

      name        = "mysql"
      port        = 6033
      target_port = 6033
    }
    type = "LoadBalancer" # LoadBalancer \ ClusterIP
  }
}


resource "kubernetes_service_v1" "proxysql_admin" {
  metadata {
    name = "proxysql-admin"
  }
  spec {
    selector = {
      app = "proxysql"
    }
    port {
      name        = "admin"
      port        = 6032
      target_port = 6032
    }
    type = "ClusterIP"
  }
}
