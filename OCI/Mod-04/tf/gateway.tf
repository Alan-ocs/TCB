resource "oci_core_internet_gateway" "mod04_internet_gw" {
    compartment_id = var.recursosRedes
    vcn_id = oci_core_vcn.vcn_mod04.id
    display_name = "mod04_internet_gw"
}

