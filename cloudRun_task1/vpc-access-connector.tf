resource "google_vpc_access_connector" "maven" {
  name          = "vpc-con"
  region = "us-central1"
  ip_cidr_range = "10.8.0.0/28"
  network       = "default"
  #id = "projects/mythic-handler-341608/locations/us-central1/connectors/python"
}
