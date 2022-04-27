resource "google_project_service" "run_api" {
  service = "run.googleapis.com"

  disable_on_destroy = true
}

resource "google_cloud_run_service" "default" {
  name     = "cloudrun-srv"
  location = "us-central1"

  template {
    spec {
      service_account_name = google_service_account.maven-exec.email
      containers {
        image = "gcr.io/mythic-handler-341608/hellospring"
        #ports {
        #    container_port = "8080"
        #  }
        }

    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "1000"
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.instance.connection_name
        "run.googleapis.com/client-name"        = "terraform"
        "run.googleapis.com/vpc-access-connector" = "vpc-con"
      }
    }
  }
  autogenerate_revision_name = true
  depends_on = [google_vpc_access_connector.maven]
}

resource "google_sql_database_instance" "instance" {
  name             = "cloudrun-sql"
  region           = "us-east1"
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "false"
}

resource "google_redis_instance" "cache" {
  name           = "memory-cache"
  memory_size_gb = 4
}
