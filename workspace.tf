resource "kubernetes_persistent_volume_claim" "workspace_pvc" {
  metadata {
    name = "workspace-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "3Gi"
      }
    }
  }
}

resource "kubernetes_deployment" "workspace" {
  metadata {
    name = "workspace"

    labels = {
      app = "workspace"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "workspace"
      }
    }

    template {
      metadata {
        labels = {
          app = "workspace"
        }
      }

      spec {
        volume {
          name = "vol-workspace-pvc"

          persistent_volume_claim {
            claim_name = "workspace-pvc"
          }
        }

        container {
          name  = "nextcloud"
          image = "nextcloud:19"

          env {
            name = "FOO"
            value = "BAR"
          }

          env {
            name = "SQLITE_DATABASE"
          }

          env {
            name  = "NEXTCLOUD_ADMIN_USER"
            value = "eoepca"
          }

          env {
            name  = "NEXTCLOUD_ADMIN_PASSWORD"
            value = "telespazio"
          }

          env {
            name  = "NEXTCLOUD_TRUSTED_DOMAINS"
            value = "\"*\""
          }

          volume_mount {
            name       = "vol-workspace-pvc"
            mount_path = "/var/www/html"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "workspace" {
  metadata {
    name = "workspace"

    labels = {
      app = "workspace"
    }
  }

  spec {
    port {
      protocol    = "TCP"
      port        = 80
      target_port = "80"
      node_port   = 32000
    }

    selector = {
      app = "workspace"
    }

    type = "NodePort"
  }
}

