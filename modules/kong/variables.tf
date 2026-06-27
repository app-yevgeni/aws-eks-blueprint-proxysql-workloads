variable "name" {
  description = "The name of the service/ingress"
  type        = string
  default     = "httpd-server"
}

variable "namespace" {
  description = "Namespace where the ingress and service are deployed"
  type        = string
  default     = "default"
}

variable "host" {
  description = "Hostname for ingress"
  type        = string
  default     = "app.crypterio.co"
}

variable "service_port" {
  description = "Port of the backend service"
  type        = number
  default     = "8080"
}
