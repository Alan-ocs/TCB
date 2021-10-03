resource "oci_core_vcn" "tcb_vcn" {

    compartment_id = var.recursosRedes
    cidr_block = "10.0.0.0/16"
    display_name = "tcb-vcn"
    dns_label = "tcbvcn"
}

resource "oci_core_subnet" "subnet_A_publica" {
    cidr_block = "10.0.10.0/24"
    display_name = "subnet_A_publica"
    compartment_id = var.recursosRedes
    vcn_id = oci_core_vcn.tcb_vcn.id
    
}

resource "oci_core_subnet" "subnet_B_privada" {
    cidr_block = "10.0.20.0/24"
    display_name = "subnet_B_privada"
    compartment_id = var.recursosRedes
    vcn_id = oci_core_vcn.tcb_vcn.id
    prohibit_public_ip_on_vnic = true
    
}