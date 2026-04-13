output "svc-ip" {
  value = kubernetes_service_v1.svc.spec[0].cluster_ip
}


