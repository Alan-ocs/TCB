resource "oci_identity_user" "Alan" {
    compartment_id = var.tenancy_ocid
    description = "Admin"
    name = "Alan"
}

