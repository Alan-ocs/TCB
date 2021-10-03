resource "oci_core_instance" "vm-webserver" {
  compartment_id      = var.recursosCompute
  availability_domain = var.availability_domain
  display_name        = "vm-webserver"
  shape               = "VM.Standard.E2.1.Micro"

  connection {
      oci_core_vcn = "vcn_mod04"
      oci_core_subnet = "subnet_publica"
  }

  metadata = {
    ssh_authorized_keys = "${file(var.ssh_public_key_file)}"
  }
}