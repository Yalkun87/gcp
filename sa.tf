resource "google_service_account" "sa_backet" {
  account_id   = "bucket-service-account"
  display_name = "A service account for bucket"
}

resource "google_project_iam_custom_role" "bucket-role" {
  role_id     = "myCustomRole"
  title       = "Role for k8b"
  description = "Role with create and list objects in the buckets"
  permissions = ["storage.objects.create", "storage.objects.list", "storage.objects.get"]
}
#project = "mythic-handler-341608"
resource "google_project_iam_binding" "store_user" {
  project = "mythic-handler-341608"
  role    = "projects/mythic-handler-341608/roles/myCustomRole"
  members = [
    "serviceAccount:${google_service_account.sa_backet.email}"
  ]
}


resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}
