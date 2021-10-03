resource "oci_core_internet_gateway" "tcb_internet_gw" {
    compartment_id = var.recursosRedes
    vcn_id = oci_core_vcn.tcb_vcn.id
    display_name = "tcb_internet_gw"
}

resource "oci_core_nat_gateway" "tcb_net_gw" {
    compartment_id = var.recursosRedes
    vcn_id = oci_core_vcn.tcb_vcn.id
    display_name = "tcb_net_gw"
}