resource "oci_identity_group" "CloudAdmin" {
    compartment_id = var.tenancy_ocid
    description = "Users with Admin Profile"
    name = "CloudAdmin" 
}

resource "oci_identity_group" "DBA" {
    compartment_id = var.tenancy_ocid
    description = "Users with DBA access only Profile"
    name = "DBA" 
}