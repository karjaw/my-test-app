# my app

provider "google" {
  credentials = file("/home/karjaw/Documents/forward-lead-435308-d1-e5c7736d5de7.json")
  project     = var.project
  region      = var.location
}

# cluster

resource "google_container_cluster" "primary" {
  name               = "my-test-cluster"
  location           = "europe-central2"
  initial_node_count = 1
  deletion_protection = false

  node_config {
    machine_type = var.machine_type
    preemptible = true
    disk_size_gb = 50
  }
}

# credentials

data "google_client_config" "default" {}

provider "kubernetes" {
  config_path = "home/karjaw/test_project/my_kubeconfig.yaml"
  host                   = google_container_cluster.primary.endpoint
  cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
  token                  = data.google_client_config.default.access_token
}

# helm

provider "helm" {
  kubernetes {
    host                   = google_container_cluster.primary.endpoint
    cluster_ca_certificate = base64decode(google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

# argocd

resource "helm_release" "argocd" {
  name       = "argocd"
  chart      = "argo-cd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"

  create_namespace = true

  values = [
    <<EOF
    server:
      service:
        type: LoadBalancer
    EOF
  ]
}
