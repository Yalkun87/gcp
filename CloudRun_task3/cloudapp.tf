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
        image = "gcr.io/mythic-handler-341608/cloud-sql"
        #ports {
        #    container_port = "8080"
        #  }
        env {
          name = "INSTANCE_CONNECTION_NAME"
          value = "mythic-handler-341608:us-central1:main-instance-2"
        }
        env {
          name = "DB_USER"
          value = "me"
        }
        env {
          name = "DB_PASS"
          value = "changeme"
        }
        env {
          name = "DB_NAME"
          value = "my-database"
        }
        }

    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "1000"
        "run.googleapis.com/cloudsql-instances" = google_sql_database_instance.main-1.connection_name
        "run.googleapis.com/client-name"        = "terraform"
        "run.googleapis.com/vpc-access-connector" = "vpc-con"
      }
    }
  }
  autogenerate_revision_name = true
  depends_on = [google_vpc_access_connector.maven]
}
