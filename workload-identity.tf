#module "my-app-workload-identity" {
#  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
#  use_existing_gcp_sa = true
#  name                = google_service_account.sa_backet.account_id
#  project_id          = "mythic-handler-341608"

  # wait for the custom GSA to be created to force module data source read during apply
  # https://github.com/terraform-google-modules/terraform-google-kubernetes-engine/issues/1059
  #depends_on = [google_service_account.sa_backet]
#}
#module "kubernetes-engine" {
#  source  = "terraform-google-modules/kubernetes-engine/google"
#  version = "20.0.0"
  # insert the 4 required variables here
#}

#module "my-app-workload-identity" {
#  source  = "terraform-google-modules/kubernetes-engine/google"
#  version = "20.0.0"
#  name       = "cloud-sql-postges"
  #cluster_name = "marcellus-wallace"
#  namespace  = "default"
#  project_id = "mythic-handler-341608"
#  roles      = ["roles/cloudsql.admin"]
#  depends_on = [google_container_cluster.primary]
#}

module "my-app-workload-identity" {
  source     = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  name       = "cloud-sql-postges"
  namespace  = "default"
  project_id = "mythic-handler-341608"
  use_existing_k8s_sa = "false" 
  roles      = ["roles/cloudsql.admin"]
  depends_on = ["google_service_account.default", "google_container_cluster.primary"]
}
