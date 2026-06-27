
###  ---  Application  ---  ###
module "httpd" {
  source = "./modules/httpd"
  depends_on = [kubernetes_namespace.migration]

  name   = "httpd-server"
  namespace = "default"
  replicas  = 1
  image = "virtapp/apache:7f6c4bf4-3-6"
  service_port = 8080
  service_type = "ClusterIP"
}

module "local-exec" {
  source = "./modules/local-exec"
  depends_on = [module.httpd]
}

module "kong" {
  source = "./modules/kong"
  depends_on = [module.httpd]
}

module "minio" {
  source = "./modules/minio"
  depends_on = [module.kong]
}

module "velero" {
  source = "./modules/velero"
  depends_on = [module.minio]
}

module "velero-ui" {
  source = "./modules/velero-ui"
  depends_on = [module.velero]
}
