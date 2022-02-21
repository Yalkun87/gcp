terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.15.0"
    }
  }
}

provider "google" {
  credentials = file("terraform-admin.json")

  project = "mythic-handler-341608"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name                    = "ymametsupiyev-vpc"
  description = "My first VPC"
  auto_create_subnetworks = false
}

resource "google_compute_firewall" "external-internal-fw" {
  name    = "ymametsupiyev-firewall"
  description = "FW allow http,https ssh and other ports"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "22", "443", "0-65535"]
  }
  target_tags = ["http-server", "https-server"]
}

resource "google_compute_subnetwork" "private_network_1" {
  name          = "private-n-1"
  description = "Private Network"
  ip_cidr_range = "10.1.1.0/24"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "public_network_1" {
  name          = "public-n-1"
  description = "Public Network"
  ip_cidr_range = "10.1.2.0/24"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_instance" "vm" {
  name                    = var.nginx
  machine_type            = var.machine_type
  deletion_protection     = "true"
  tags                    = ["http-server", "https-server"]
  metadata_startup_script = file("nginx_install.sh")

  metadata = {
    server_type = "nginx_server"
    os_family   = "debian"
  }
  timeouts {
    delete = "40m"
  }
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
      size  = "${var.disk_size}"
      type  = "${var.disk_type}"
  }
}
  network_interface {
    subnetwork = "public-n-1"

    access_config {
  }
}
}
