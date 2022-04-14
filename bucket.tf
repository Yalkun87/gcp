resource "google_storage_bucket" "bucket-a" {
  name          = "page-store"
  location      = "EU"
  force_destroy = true
}
