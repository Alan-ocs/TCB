data "google_compute_zones" "available" {
  region = var.gcp_region
}

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
  subnetwork = google_compute_subnetwork.tcb-gcp-subnet1.name
  network_ip = var.gcp_vm_address_eua-app01
  access_config {
     }
  }

}

resource "google_compute_instance" "eua-db01" {
  name         = "eua-db01"
  machine_type = var.gcp_instance_type
  zone = var.gcp_zone

  boot_disk {
    initialize_params {
      image = var.gcp_disk_image
    }
  }

  network_interface {
  subnetwork = google_compute_subnetwork.tcb-gcp-subnet1.name
  network_ip = var.gcp_vm_address_eua-db01
  access_config {
     }
  }

  # provisioner "local-exec" {
  # command = <<EOH
  #   sudo apt update
  #   sudo apt-get -y install wget
  #   wget http://repo.mysql.com/mysql-apt-config_0.8.13-1_all.deb
  #   dpkg -i mysql-apt-config_0.8.13-1_all.deb
  #   sudo apt update
  #   sudo apt install mysql-server -y
  #   sudo mysqladmin -u root password welcome1
  #   sudo systemctl restart mysql.service
  #   EOH
  # }

}



