resource "google_compute_instance" "eua-db01" {
  name         = "eua-db01"
  machine_type = var.gcp_instance_type
  zone = var.gcp_zone

 # metadata_startup_script = <<SCRIPT
 #     sudo apt update 
 #     sudo apt-get -y install wget
 #     wget http://repo.mysql.com/mysql-apt-config_0.8.13-1_all.deb
 #     dpkg -i mysql-apt-config_0.8.13-1_all.deb
 #     sudo apt install mysql-server -y
 #     sudo mysqladmin -u root password welcome1
 #     sudo systemctl restart mysql.service
 #     SCRIPT

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

  provisioner "remote-exec" {
      connection {
      host = "eua-db01"
      type = "ssh"
      port = 22
      user = "root"
      timeout = "500s"
      agent = "false"
      private_key = file("/home/ubuntu/Documents/TCB/GCP/05/root.pub")
      }
    inline = [
    "sudo apt update", 
    "sudo apt-get -y install wget", 
    "wget http://repo.mysql.com/mysql-apt-config_0.8.13-1_all.deb", 
    "dpkg -i mysql-apt-config_0.8.13-1_all.deb", 
    "sudo apt install mysql-server -y", 
    "sudo mysqladmin -u root password welcome1", 
    "sudo systemctl restart mysql.service"
      ]
  }


  }