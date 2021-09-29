resource "google_compute_instance" "default" {
 count        = var.instance_count
 name         = "vm-0${count.index +1}"
 machine_type = "f1-micro"
 zone         = "us-east1-b"
 project      = var.project

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }
 
 network_interface {
   network = "default"
 }
}
