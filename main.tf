terraform {
  required_version = "1.14.8"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~>3.0.1"
    }
  }
}


resource "kubernetes_deployment_v1" "deploy" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels = {
      app = var.name
    }
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = var.name
      }
    }
    template {
      metadata {
        labels = {
          app = var.name
        }
      }
      spec {
        container {
          image = var.image
          name  = "${var.name}-container"
          resources {
            limits = {
              cpu    = "50m"
              memory = "50Mi"
            }
          }
          dynamic "port" {
            for_each = toset(var.container-ports)
            content {
              container_port = port.value
            }
          }
        }
      }
    }
  }
}


resource "kubernetes_service_v1" "svc" {
  metadata {
    name = var.name
    namespace = var.namespace
    labels = {
      app = var.name
    }
  }
  spec {
    selector = {
      app = var.name
    }
    port {
      port = var.svc-port
    }
  }
}
