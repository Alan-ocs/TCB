resource "oci_core_instance" "webserver" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = var.compartment_ocid
  display_name        = "webserver"
  shape               = "VM.Standard.E2.1.Micro"
  defined_tags        = {"desenvolvimento":"Key",
                        "aplicacao":"videobackup"}

  create_vnic_details {
    subnet_id        = oci_core_subnet.subnet2.id
    display_name     = "subnet2"
    assign_public_ip = true
    hostname_label   = "webserver"
  }

  source_details {
    source_type = "image"
    source_id   = var.images[var.region]
  }

  provisioner "local-exec" {
    command = "sleep 60"
  }

  provisioner "remote-exec" {
      inline = ["sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp",
                "sudo firewall-cmd --reload",
                "python3 -m venv py36env",
                "source py36env/bin/activate",
                "wget https://objectstorage.us-ashburn-1.oraclecloud.com/p/V7oHPoleSVsmGaNcR7_mGEOrXtuHuhN7OsUJEF2rIY5EoKyNjz759bux1L4Ppn3b/n/idqfa2z2mift/b/bootcamp-oci/o/oci-f-handson-modulo-storage-appfiles.zip",
                "unzip oci-f-handson-modulo-storage-appfiles.zip",
                "pip install -r requirements.txt",
                "export FLASK_SECRET='394jmga9flsjc81njosn32jociq7loh4e9nqge8hkuaein8348sm'",
                "export BUCKET_NAME='tcbvideobackupaocs'",
                "gunicorn app:app  --config=config.py"]

      connection {
        host = self.public_ip
        type = "ssh"
        user = "opc"
        private_key = var.ssh_private_key_file
      }
  }              

  metadata = {
    ssh_authorized_keys = var.ssh_public_key_file
  }  
}

output "Instance_Public_IP" {
  value = [oci_core_instance.webserver.public_ip]
}
