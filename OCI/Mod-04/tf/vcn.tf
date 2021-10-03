resource "oci_core_vcn" "vcn_mod04" {

    compartment_id = var.recursosRedes
    cidr_block = "172.16.0.0/16"
    display_name = "vcn_mod04"
    dns_label = "vcnmod04"
}

resource "oci_core_subnet" "subnet_publica" {
    cidr_block = "172.16.10.0/24"
    display_name = "subnet_publica"
    compartment_id = var.recursosRedes
    vcn_id = oci_core_vcn.vcn_mod04.id
#   prohibit_public_ip_on_vnic = true
}
