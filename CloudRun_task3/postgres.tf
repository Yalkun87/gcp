resource "google_sql_database_instance" "main-1" {
  name             = "main-instance-2"
  database_version = "POSTGRES_11"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name     = "me"
  instance = google_sql_database_instance.main-1.name
  host     = "me.com"
  password = "changeme"
}

resource "google_sql_database" "database" {
  name     = "my-database"
  instance = google_sql_database_instance.main-1.name
}
