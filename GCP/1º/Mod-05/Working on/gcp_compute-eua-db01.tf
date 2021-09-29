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
        network = "default"
    access_config {
    }
  }

  metadata = {
  ssh-keys = "${var.username}:${file("${var.key_priv}")}"
  }

  connection {
    host = self.network_interface.0.access_config.0.nat_ip
    type = "ssh"
    user = var.username
    agent = "false"
    private_key = file(var.key_priv)
    }


  provisioner "local-exec" {
  command = "ansible-playbook -i '${self.network_interface.0.access_config.0.nat_ip},' --private-key ${var.key_priv} mysql.yml"
  }
 
#    provisioner "remote-exec" {

#     inline = [
#     "sudo apt update", 
#     "sudo apt-get -y install wget", 
#     "wget http://repo.mysql.com/mysql-apt-config_0.8.13-1_all.deb", 
#     "dpkg -i mysql-apt-config_0.8.13-1_all.deb", 
#     "sudo apt install mysql-server -y", 
#     "sudo mysqladmin -u root password welcome1", 
#     "sudo systemctl restart mysql.service"
#       ]
#   }
}