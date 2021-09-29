resource "google_compute_firewall" "ssh-rule" {
  name = "allow-ssh"
  network = "tcb-gcp-network"
  allow {
    protocol = "tcp"
    ports = ["22"]
  }
  target_tags = ["eua-db01", "eua-app01"]
  source_ranges = ["0.0.0.0/0"]
}
