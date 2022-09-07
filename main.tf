# project

variable "project_name" {
  type = string
}

variable "project_region" {
  type = string
  default = "us-central1"
}

variable "location" {
  type = string
  default = "asia-northeast1"
}

variable "cluster_name" {
  type = string
}


provider "google" {
  credentials = file("account.json")
  project     = var.project_name
  region      = var.project_region
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.location

  enable_autopilot = true
  ip_allocation_policy {
  }
}

resource "google_gke_hub_membership" "membership" {
  membership_id = "ggsupoter-member"
  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${google_container_cluster.primary.id}"
    }
  }
}