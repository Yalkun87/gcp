data "google_container_registry_image" "run-sql" {
  name = "run-sql"
  project = "mythic-handler-341608"
}

output "gcr_location" {
  value = data.google_container_registry_image.run-sql.image_url
}
