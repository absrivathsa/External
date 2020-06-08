resource "kubernetes_deployment" "internal-deployment" {
  metadata {
    name = "internal-deployment"
    labels = {
      App = "events"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 1
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "events"
      }
    }
    template {
      metadata {
        labels = {
          App = "events"
        }
      }
      spec {
        container {
          image = "gcr.io/dtc-user13/internal-image:v1.0.0"
          name  = "internal"

          port {
            container_port = 8082
          }

          resources {
            limits {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}