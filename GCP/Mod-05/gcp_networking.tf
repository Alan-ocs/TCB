resource "google_compute_network" "tcb-gcp-network" {
  name                    = "tcb-gcp-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "tcb-gcp-subnet1" {
  name          = "tcb-gcp-subnet1"
  ip_cidr_range = var.gcp_subnet1_cidr
  network       = google_compute_network.tcb-gcp-network.name
  region        = var.gcp_region
}

