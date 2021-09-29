resource "google_compute_instance" "eua-app01" {
  name         = "eua-app01"
  machine_type = var.gcp_instance_type
  zone = var.gcp_zone

    boot_disk {
      initialize_params {
        image = var.gcp_disk_image
      }
    }

    network_interface {
        network = "default"
    access_config {
    }
  }

}