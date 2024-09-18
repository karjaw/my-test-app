variable "project" {
  type = string
  default = "forward-lead-435308-d1"
}

variable "region" {
  type = string
  default = "europe-central2"
}

variable "location" {
  type = string
  default = "europe-central2-a"
}

variable "machine_type" {
  type = string
  default = "e2-medium"
}

provider "google" {
  credentials = file("/home/karjaw/Documents/forward-lead-435308-d1-e5c7736d5de7.json")
  project     = var.project
  region      = var.region
}

resource "google_container_cluster" "primary" {
  name     = "my-test-cluster"
  location = var.location
  initial_node_count = 1
  node_config {
    machine_type = var.machine_type
    disk_size_gb = 50
  }
}
