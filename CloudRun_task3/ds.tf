data "google_container_registry_image" "cloud-sql" {
  name = "cloud-sql"
}

output "gcr_location" {
  value = data.google_container_registry_image.cloud-sql.image_url
}
