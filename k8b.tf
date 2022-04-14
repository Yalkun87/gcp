resource "google_container_cluster" "primary" {
  name               = "marcellus-wallace"
  location           = "us-central1"
  initial_node_count = 1

  node_locations = [
    "us-central1-c",
  ]

  workload_identity_config {
  workload_pool = "mythic-handler-341608.svc.id.goog"
}

  node_config {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}


resource "google_container_node_pool" "np" {
  name       = "my-node-pool"
  cluster    = google_container_cluster.primary.id
  node_count = 1
  node_config {
    machine_type = "e2-medium"
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.sa_backet.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
