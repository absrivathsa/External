resource "kubernetes_deployment" "external-deployment" {
  metadata {
    name = "external-deployment"
    labels = {
      App = "events"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 3
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
          image = "gcr.io/dtc-user13/external-image:v1.0.1"
          name  = "external"

          port {
            container_port = 8080
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