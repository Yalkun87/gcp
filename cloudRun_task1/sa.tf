resource "google_service_account" "maven-exec" {
  account_id   = "maven-exec-service-account"
  display_name = "A service account for maven-exec"
}

#resource "google_project_iam_custom_role" "python_exec-role" {
##  title       = "Role for k8b"
  #description = "Role with create and list objects in the buckets"
  #permissions = ["storage.objects.create", "storage.objects.list", "storage.objects.get"]
#}
#project = "mythic-handler-341608"
resource "google_project_iam_member" "maven-exec" {
  project = "mythic-handler-341608"
  #service_account_id = google_service_account.maven-exec.name
  role    = "roles/datastore.owner"
  member = "serviceAccount:${google_service_account.maven-exec.email}"
}

resource "google_project_iam_member" "maven-exec3" {
  project = "mythic-handler-341608"
  #service_account_id = google_service_account.maven-exec.name
  role    = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.maven-exec.email}"

}

resource "google_project_iam_member" "maven-exec4" {
  project = "mythic-handler-341608"
  #service_account_id = google_service_account.maven-exec.name
  role    = "roles/redis.admin"
  member = "serviceAccount:${google_service_account.maven-exec.email}"

}

resource "google_project_iam_member" "maven-exec5" {
  project = "mythic-handler-341608"
  #service_account_id = google_service_account.maven-exec.name
  role    = "roles/cloudsql.admin"
  member = "serviceAccount:${google_service_account.maven-exec.email}"

}
