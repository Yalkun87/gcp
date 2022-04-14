module "my-app-workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name       = "cloud-sql-postges"
  namespace  = "default"
  project_id = "mythic-handler-341608"
  use_existing_k8s_sa = "false" 
  roles      = ["roles/cloudsql.admin"]
  depends_on = ["google_service_account.default", "google_container_cluster.primary"]
}
